$(document).on('turbolinks:load', function () {

  const bacLevel = [0.03, 0.059, 0.09, 0.19, 0.29]; // 酒測值由小到大
  const menConst = 0.73;
  const womenConst = 0.66;
  const toOunces = 0.0338;
  const toLB = 2.2;

  let liquorName = "未知";
  let weight = 0;
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

  // 設定性別函式
  function setGenderConst(gender) {
    return (gender === 0 ? menConst : womenConst)
  }

  // 計算杯數函式
  function calcDrink(bac) {
    // 設定性別
    genderConst = setGenderConst(gon.current_user_gender);
    // 設定體重
    weight = gon.current_user_weight;
    // 計算杯數
    if ((bac !== 0) && (genderConst !== 0) && (weight !== 0) && (alcoholContent !== 0)) {
      return (100 * weight * toLB * genderConst * (bac + 0.00025 * (timeBefore + timeAfter))) / (5.14 * unit * alcoholContent * toOunces)
    } else {
      console.log("calcDrink 有值為 0");
      return 0;
    }
  }

  // 計算達到酒測標準時間函式
  function calcDrive(drinksLevel) {
    // 計算式
    if ((genderConst !== 0) && (weight !== 0) && (alcoholContent !== 0)) {
      return (((205.6 * drinksLevel * unit * alcoholContent * toOunces) / (weight * toLB * genderConst))) - (timeBefore + timeAfter) - (4000 * bacLevel[0]);
    } else {
      console.log("calcDrive 有值為 0");
      return 0;
    }
  }

  // 分鐘轉時間顯示
  function minToTime(minutes) {
    let hours = 0;
    hours = Math.floor(minutes / 60);
    minutes = minutes % 60;
    return `${hours} 小時 ${minutes} 分`
  }

  // 設定 modal 內容
  function setModal(id) {
    // 取得 levelnumber 的 number(最後一個字)
    id = id[id.length - 1];
    $(`#exampleModalLongTitle`).text(levelText[id - 1]);
    $(`#modal-bac`).text(`血酒濃度：${bacLevel[id - 1]} %`);
    $(`.modal-body .info .level${id}`).show();
    $(`#after-drink`).text(driveText[id - 1]);
  }

  // 變更層級按鈕
  function changeButton() {
    // 分次計算不同程度所需的杯數並輸入進 array
    for (let i = 0; i < 5; i++) {
      maxDrinksLevel[i] = Math.floor((calcDrink(bacLevel[i])) * 10) / 10;
    }

    // 設定各杯數文字內容
    levelText[0] = `（正常）：${liquorName} ${maxDrinksLevel[0]} 杯`;
    levelText[1] = `心情愉悅：${liquorName} ${maxDrinksLevel[1]} 杯`;
    levelText[2] = `外向亢奮：${liquorName} ${maxDrinksLevel[2]} 杯`;
    levelText[3] = `噁心想吐：${liquorName} ${maxDrinksLevel[3]} 杯`;
    levelText[4] = `記憶斷片：${liquorName} ${maxDrinksLevel[4]} 杯`;

    // 轉換杯數文字 array 進 html 內
    for (let i = 0; i < 5; i++) {
      $(`#level${i+1}`).text(levelText[i]);
    }

    // 設定達到酒測值的文字 array
    for (let i = 0; i < 5; i++) {
      safeDrive[i] = Math.ceil(calcDrive(maxDrinksLevel[i]));
    }

    // 轉換酒測標準文字 array 進 html
    for (let i = 0; i < 5; i++) {
      if (safeDrive[i] <= 0) {
        driveText[i] = `血酒濃度低於酒測標準 ${bacLevel[0]} %`;
      } else {
        driveText[i] = `結束後 ${minToTime(safeDrive[i])}，血酒濃度可低於酒測標準 ${bacLevel[0]} %`;
      }
    }
  }

  // 事件
  // 選擇酒類
  $('#calc-drinks input[type=radio]').click(function (e) {
    // 抓取飲品酒精濃度並轉為數字
    alcoholContent = $('#calc-drinks input[type=radio]:checked').val();
    alcoholContent = Number(alcoholContent);
    // 抓取飲品名字
    liquorName = $(this).attr('data');
    // 設定選取選項的外觀
    $('#calc-drinks label').removeClass('for-checked-form-group');
    $(this).parent('label').addClass('for-checked-form-group');
    changeButton();
  })

  // 選單事件
  // 選擇開始時間
  $('select[name="time-before"]')
    .change(function () {
      timeBefore = $('select[name="time-before"] option:selected').val();
      timeBefore = Number(timeBefore);
    })

  // 選擇結束時間
  $('select[name="time-after"]')
    .change(function () {
      timeAfter = $('select[name="time-after"] option:selected').val();
      timeAfter = Number(timeAfter);
    })

  // 選擇單位
  $('select[name="unit"]')
    .change(function () {
      unit = $('select[name = "unit"] option:selected').val();
      unit = Number(unit);
    })


  // 按鈕事件
  // 下一步
  $("#next-step").click(function () {
    // 如果第一次按要展開 如果第二次就不會再展開(時間選擇區(第二區塊))
    if (alcoholContent !== 0  && rightPage) {
      $("#start").removeClass("d-none");
      rightPage = false;
    } else if (alcoholContent == 0) {
      $('#error_message').html('<p>請先選擇一種酒</p>');
      $('#error_message').addClass('error_message');
    }
    if (alcoholContent !== 0) {
      $(window).scrollTop(10000);
    }
  });

  // 顯示計算結果並捲動到底部
  $("#to-result").click(function () {
    $("#time-unit").addClass("d-none");
    $("#result-step").removeClass("d-none");
    $(window).scrollTop(10000);
    changeButton();
  });

  // 回到選酒頁並捲到到頂部
  $("#to-time-unit").click(function () {
    $("#result-step").addClass("d-none");
    $("#time-unit").removeClass("d-none");
    $(window).scrollTop(top);
    changeButton();
  });

  // 綁定杯數按鈕事件
  $('#result button').click(function (e) {
    // 隱藏 modal 內部對身體影響的資料
    $(`.modal-body .info li`).hide();
    setModal($(this).attr('id'));
  })
  // 輸入檢查綁定
  $('#volume_alcohol').focusout(function () {
    if ($('#volume_alcohol').val() == ''){
      $('#volume_alcohol + span').removeClass('d-none');
    }
  })
  $('#volume_alcohol').focusin(function () {
    $('#volume_alcohol + span').addClass('d-none');
  })
  $('#ratio').focusout(function () {
    if (($('#ratio').val()) == '') {
      $('#ratio + span').removeClass('d-none');
    }
  })
  $('#ratio').focusin(function () {
    $('#ratio + span').addClass('d-none');
  })
  $('#label_name-user-define').focusout(function () {
    if (($('#label_name-user-define').val()) == '') {
      $('#label_name-user-define + div span').removeClass('d-none');
    }
  })
  $('#label_name-user-define').focusin(function () {
    $('#label_name-user-define + div span').addClass('d-none');
  })

  // 動畫按鈕綁定
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