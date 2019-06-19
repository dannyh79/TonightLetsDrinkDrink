$(document).on('turbolinks:load', function () {

  const bacLevel = [0.03, 0.059, 0.09, 0.19, 0.29]; // 酒測值由小到大
  const menConst = 0.73;
  const womenConst = 0.66;
  const toOunces = 0.0338;
  const toLB = 2.2;

  let liquorName = "未知";
  let weight = 0;
  let gender = 0;
  let timeBefore = 0;
  let timeAfter = 0;
  let alcoholContent = 0; // 酒品的酒精濃度
  let unit = 330; // 先給預設值 330 ml 有 change 才改成新的值

  let maxDrinksLevel = [0, 0, 0, 0, 0]
  let safeDrive = [0, 0, 0, 0, 0]
  let levelText = ["", "", "", "", ""]
  let driveText = ["", "", "", "", ""]
  let genderConst = 0;
  let rightPage = true;

  function setGenderConst(gender) {
    return (gender === 0 ? menConst : womenConst)
  }

  function calcDrink(bac) {
    genderConst = setGenderConst(gon.current_user_gender);
    weight = gon.current_user_weight;
    if ((bac !== 0) && (genderConst !== 0) && (weight !== 0) && (alcoholContent !== 0)) {
      return (100 * weight * toLB * genderConst * (bac + 0.00025 * (timeBefore + timeAfter))) / (5.14 * unit * alcoholContent * toOunces)
    } else {
      console.log("calcDrink 有值為 0");
      return 0;
    }
  }

  function calcDrive(drinksLevel) {
    if ((genderConst !== 0) && (weight !== 0) && (alcoholContent !== 0)) {
      return (((205.6 * drinksLevel * unit * alcoholContent * toOunces) / (weight * toLB * genderConst))) - (timeBefore + timeAfter) - (4000 * bacLevel[0]);
    } else {
      console.log("calcDrive 有值為 0");
      return 0;
    }
  }

  function minToTime(minutes) {
    let hours = 0;
    hours = Math.floor(minutes / 60);
    minutes = minutes % 60;
    return `${hours} 小時 ${minutes} 分`
  }

  function setModal(id) {
    // 取得 levelnumber 的 number(最後一個字)
    id = id[id.length - 1];
    $(`#exampleModalLongTitle`).text(levelText[id - 1]);
    $(`#modal-bac`).text(`血酒濃度：${bacLevel[id - 1]} %`);
    $(`.modal-body .info .level${id}`).show();
    $(`#after-drink`).text(driveText[id - 1]);
    // console.log(driveText[id -1]);
  }

  // 變更層級按鈕
  function changeButton() {
    for (let i = 0; i < 5; i++) {
      maxDrinksLevel[i] = Math.floor((calcDrink(bacLevel[i])) * 10) / 10;
    }

    levelText[0] = `（正常）：${liquorName} ${maxDrinksLevel[0]} 杯`;
    levelText[1] = `心情愉悅：${liquorName} ${maxDrinksLevel[1]} 杯`;
    levelText[2] = `亢奮：${liquorName} ${maxDrinksLevel[2]} 杯`;
    levelText[3] = `噁心想吐：${liquorName} ${maxDrinksLevel[3]} 杯`;
    levelText[4] = `「斷片」：${liquorName} ${maxDrinksLevel[4]} 杯`;

    for (let i = 0; i < 5; i++) {
      $(`#level${i+1}`).text(levelText[i]);
    }


    for (let i = 0; i < 5; i++) {
      safeDrive[i] = Math.ceil(calcDrive(maxDrinksLevel[i]));
    }

    for (let i = 0; i < 5; i++) {
      if (safeDrive[i] <= 0) {
        driveText[i] = `血酒濃度低於酒測標準 ${bacLevel[0]} %`;
        // console.log(driveText[i]);
      } else {
        driveText[i] = `結束後 ${minToTime(safeDrive[i])}，血酒濃度可低於酒測標準 ${bacLevel[0]} %`;
        // console.log(driveText[i]);
      }
    }
  }

  // 選擇酒類
  $('#calc-drinks input[type=radio]').click(function (e) {
    alcoholContent = $('#calc-drinks input[type=radio]:checked').val();
    alcoholContent = Number(alcoholContent);
    liquorName = $(this).attr('data');
    console.log(liquorName)
    // $('#calcdrinks .form-grop input').removeClass('for-checked-form-group');
    $('#calc-drinks label').removeClass('for-checked-form-group');
    $(this).parent('label').addClass('for-checked-form-group');
    // console.log(this);    
    changeButton();
  })
  $('select[name="time-before"]')
    .change(function () {
      timeBefore = $('select[name="time-before"] option:selected').val();
      timeBefore = Number(timeBefore);
      // console.log(timeBefore);
      // changeButton();
    })
  $('select[name="time-after"]')
    .change(function () {
      timeAfter = $('select[name="time-after"] option:selected').val();
      timeAfter = Number(timeAfter);
      // console.log(timeAfter);
      // changeButton();
    })
  $('select[name="unit"]')
    .change(function () {
      unit = $('select[name = "unit"] option:selected').val();
      unit = Number(unit);
      // console.log(unit);
      // changeButton();
    })


  // 按鈕事件
  $("#next-step").click(function () {
    if (alcoholContent !== 0  && rightPage) {
      $("#start").removeClass("d-none");
      rightPage = false;
    }
    if (alcoholContent !== 0) {
      $(window).scrollTop(10000);
    }
  });
  $("#to-result").click(function () {
    $("#time-unit").addClass("d-none");
    $("#result-step").removeClass("d-none");
    $(window).scrollTop(10000);
    changeButton();
  });
  $("#to-time-unit").click(function () {
    $("#result-step").addClass("d-none");
    $("#time-unit").removeClass("d-none");
    $(window).scrollTop(top);
    changeButton();
  });


  $('#result button').click(function (e) {
    $(`.modal-body .info li`).hide();
    setModal($(this).attr('id'));
  })
  // mk 以上重構完成
  $('#next-step').click(function(e) {
    e.preventDefault();
    const timeUnit = $('#time-unit');
    timeUnit.show();
    const top = timeUnit.offset().top;
    $(window).scrollTop(top);
  })
  
  $('#next-result').click(function(e) {
    e.preventDefault();
    const result = $('#result');
    result.show();
    const top = result.offset().top;
    $(window).scrollTop(top);
  })
  
  $('#level1').on('click', function() {
    $('#water-level').removeAttr("class")
    $('#water-level').addClass('level_1')
  });
  
  $('#level2').on('click', function() {
    $('#water-level').removeAttr("class")
    $('#water-level').addClass('level_2')
  });
  
  $('#level3').on('click', function() {
    $('#water-level').removeAttr("class")
    $('#water-level').addClass('level_3')
  });
  
  $('#level4').on('click', function() {
    $('#water-level').removeAttr("class")
    $('#water-level').addClass('level_4')
  });
  
  $('#level5').on('click', function() {
    $('#water-level').removeAttr("class")
    $('#water-level').addClass('level_5')
  });

});