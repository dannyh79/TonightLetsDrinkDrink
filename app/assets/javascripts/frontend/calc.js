$(document).on('turbolinks:load', function() {
  // mk 以下尚待重構
  // % BAC = (A x 5.14 / (W x r)) - 0.015 x H
  // A = n * unit * alcoholContent * toOunces / 100
  // w = weight * toLB
  const bacLevel1 = 0.03; // 安全酒測值 之後依照維基百科設置多組血酒濃度
  const bacLevel2 = 0.059;
  const bacLevel3 = 0.09;
  const bacLevel4 = 0.19;
  const bacLevel5 = 0.29;
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

  let maxDrinksLevel1, maxDrinksLevel2, maxDrinksLevel3, maxDrinksLevel4, maxDrinksLevel5 = 0;
  let levelText1, levelText2, levelText3, levelText4, levelText5 = "";
  let safeDrive1, safeDrive2, safeDrive3, safeDrive4, safeDrive5 = 0;
  let driveText1, driveText2, driveText3, driveText4, driveText5 = "";


  function calcDrink(bac, genderConst) {
    if ((bac !== 0) && (genderConst !== 0) && (weight !== 0) && (alcoholContent !== 0)) {
      return (100 * weight * toLB * genderConst * (bac + 0.00025 * (timeBefore + timeAfter))) / (5.14 * unit * alcoholContent * toOunces)
    } else {
      console.log("有值為 0");
      return 0;
    }
  }

  function calcDrive(drinksLevel, genderConst) {
    if ((genderConst !== 0) && (weight !== 0) && (alcoholContent !== 0)) {
      // return (((205.6 * unit * alcoholContent * toOunces) / weight * toLB * genderConst)) - (4000 * bacLevel1) - (timeBefore + timeAfter);
      return (((205.6 * drinksLevel * unit * alcoholContent * toOunces) / (weight * toLB * genderConst))) - (timeBefore + timeAfter) - (4000 * bacLevel1);
    } else {
      console.log("有值為 0");
      return 0;
    }
  }

  function minToTime(minutes) {
    let hours = 0;
    hours = Math.floor(minutes / 60);
    minutes = minutes % 60;
    return `${hours} 小時 ${minutes} 分`
  }
  function changeButton() {
    maxDrinksLevel1 = Math.floor((calcDrink(bacLevel1, gender)) * 10) / 10;
    maxDrinksLevel2 = Math.floor((calcDrink(bacLevel2, gender)) * 10) / 10;
    maxDrinksLevel3 = Math.floor((calcDrink(bacLevel3, gender)) * 10) / 10;
    maxDrinksLevel4 = Math.floor((calcDrink(bacLevel4, gender)) * 10) / 10;
    maxDrinksLevel5 = Math.floor((calcDrink(bacLevel5, gender)) * 10) / 10;

    console.log(`Level 01 飲用份量：${maxDrinksLevel1} 杯`);
    console.log(`Level 02 飲用份量：${maxDrinksLevel2} 杯`);
    console.log(`Level 03 飲用份量：${maxDrinksLevel3} 杯`);
    console.log(`Level 04 飲用份量：${maxDrinksLevel4} 杯`);
    console.log(`Level 05 飲用份量：${maxDrinksLevel5} 杯`);
    levelText1 = `（正常）：${liquorName} ${maxDrinksLevel1} 杯`;
    levelText2 = `心情愉悅：${liquorName} ${maxDrinksLevel2} 杯`;
    levelText3 = `亢奮：${liquorName} ${maxDrinksLevel3} 杯`;
    levelText4 = `噁心想吐：${liquorName} ${maxDrinksLevel4} 杯`;
    levelText5 = `「斷片」：${liquorName} ${maxDrinksLevel5} 杯`;
    $(`#level1`).text(levelText1);
    $(`#level2`).text(levelText2);
    $(`#level3`).text(levelText3);
    $(`#level4`).text(levelText4);
    $(`#level5`).text(levelText5);


    // console.log('lala');
    // console.log(Math.ceil(calcDrive(1, gender)));
    // console.log(Math.ceil(calcDrive(2, gender)));
    // console.log(Math.ceil(calcDrive(3, gender)));
    // console.log('haha');
    // console.log(typeof maxDrinksLevel1);
    safeDrive1 = Math.ceil(calcDrive(maxDrinksLevel1, gender));
    // console.log(safeDrive1);
    // console.log(minToTime(safeDrive1));
    // console.log(typeof safeDrive1);
    safeDrive2 = Math.ceil(calcDrive(maxDrinksLevel2, gender));
    // console.log(safeDrive2);
    // console.log(minToTime(safeDrive2));
    safeDrive3 = Math.ceil(calcDrive(maxDrinksLevel3, gender));
    // console.log(safeDrive3);
    // console.log(minToTime(safeDrive3));
    safeDrive4 = Math.ceil(calcDrive(maxDrinksLevel4, gender));
    // console.log(safeDrive4);
    // console.log(minToTime(safeDrive4));
    safeDrive5 = Math.ceil(calcDrive(maxDrinksLevel5, gender));
    // console.log(safeDrive5);
    // console.log(minToTime(safeDrive5));

    if (safeDrive1 <= 0) {
      driveText1 = `酒測值低於酒駕標準 ${bacLevel1} %`;
    } else {
      driveText1 = `結束後 ${minToTime(safeDrive1)}，可低於酒駕標準 ${bacLevel1}`;
    }
    if (safeDrive2 <= 0) {
      driveText2 = `酒測值低於酒駕標準 ${bacLevel1} %`;
    } else {
      driveText2 = `結束後 ${minToTime(safeDrive2)}，可低於酒駕標準 ${bacLevel1}`;
    }
    if (safeDrive3 <= 0) {
      driveText3 = `酒測值低於酒駕標準 ${bacLevel1} %`;
    } else {
      driveText3 = `結束後 ${minToTime(safeDrive3)}，可低於酒駕標準 ${bacLevel1}`;
    }
    if (safeDrive4 <= 0) {
      driveText4 = `酒測值低於酒駕標準 ${bacLevel1} %`;
    } else {
      driveText4 = `結束後 ${minToTime(safeDrive4)}，可低於酒駕標準 ${bacLevel1}`;
    }
    if (safeDrive5 <= 0) {
      driveText5 = `酒測值低於酒駕標準 ${bacLevel1} %`;
      // console.log('low');
    } else {
      driveText5 = `結束後 ${minToTime(safeDrive5)}，可低於酒駕標準 ${bacLevel1}`;
      // console.log('height');
    }
  }
  // calcDrink 測試參數
  weight = 70;
  gender = menConst;
  alcoholContent = 5;

  $('form[class="form alc-select"] input[type=radio]').click(function (e) {
    // 5% 的酒 每 100 ml 有 5 ml 的酒精
    alcoholContent = $('form[class="form alc-select"] input[type=radio]:checked').val();
    alcoholContent = Number(alcoholContent);
    // console.log(alcoholContent);
    // console.log(typeof alcoholContent);
    // liquorName = $('form[class="form alc-select"] input[type=radio]:checked').attr('id');
    liquorName = $(this).attr('id');
    // console.log(liquorName);
    changeButton();
  })
  $('#next-step').click(function (e) {
    if (alcoholContent !== 0) {
      e.preventDefault();
      const timeUnit = $('#time-unit');
      timeUnit.show();
      const top = timeUnit.offset().top;
      $(window).scrollTop(top);
    }
  })
  $('select[name="time-before"]')
    .change(function () {
      timeBefore = $('select[name="time-before"] option:selected').val();
      timeBefore = Number(timeBefore);
      // console.log(timeBefore);
      // console.log(typeof timeBefore);
      changeButton();
    })
  $('select[name="time-after"]')
    .change(function () {
      timeAfter = $('select[name="time-after"] option:selected').val();
      timeAfter = Number(timeAfter);
      // console.log(timeAfter);
      // console.log(typeof timeAfter);
      changeButton();
    })
  $('select[name="unit"]')
    .change(function () {
      unit = $('select[name = "unit"] option:selected').val();
      unit = Number(unit);
      // console.log(unit);
      // console.log(typeof unit);
      changeButton();
    })
  $('#next-result').click(function (e) {
    e.preventDefault();
    const result = $('#result');
    result.show();
    const top = result.offset().top;
    $(window).scrollTop(top);
    // let totalTime = timeBefore + timeAfter;
    // 檢查內容
    console.log(`體重：${weight}`);
    // console.log(typeof weight);
    console.log(`轉磅數：${toLB}`);
    // console.log(typeof toLB);
    console.log(`性別常數：${gender}`);
    // console.log(typeof gender);
    console.log(`經過多久：${timeBefore}`);
    // console.log(typeof timeBefore);
    console.log(`多久離開：${timeAfter}`);
    // console.log(typeof timeAfter);
    // console.log(`總時數：${totalTime}`);
    // console.log(typeof totalTime);
    console.log(`酒品酒精濃度：${alcoholContent}`);
    // console.log(typeof alcoholContent);
    console.log(`轉盎司${toOunces}`);
    // console.log(typeof toOunces);
    console.log(`每單位毫升${unit}`);
    // console.log(typeof unit);

    changeButton();
  })
  $('#result button').click(function (e) {
    // console.log('resultButtonClick');
    // var theID = $(this).attr('id');
    // console.log($('#result button').attr('id'));
    // console.log(theID);
    $(`.modal-body .info li`).hide();
    switch ($(this).attr('id')) {
      case "level1":
        // console.log('');
        $(`#exampleModalLongTitle`).text(levelText1);
        $(`#modal-bac`).text(`血酒濃度：${bacLevel1} %`);
        $(`.modal-body .info .level1`).show();
        $(`.modal-body h6`).text(driveText1);
        break;
      case "level2":
        // console.log('bac');
        $(`#exampleModalLongTitle`).text(levelText2);
        $(`#modal-bac`).text(`血酒濃度：${bacLevel2} %`);
        $(`.modal-body .info .level2`).show();
        $(`.modal-body h6`).text(driveText2);
        break;
      case "level3":
        // console.log('bac1');
        $(`#exampleModalLongTitle`).text(levelText3);
        $(`#modal-bac`).text(`血酒濃度：${bacLevel3} %`);
        $(`.modal-body .info .level3`).show();
        $(`.modal-body h6`).text(driveText3);
        break;
      case "level4":
        // console.log('bac1');
        $(`#exampleModalLongTitle`).text(levelText4);
        $(`#modal-bac`).text(`血酒濃度：${bacLevel4} %`);
        $(`.modal-body .info .level4`).show();
        $(`.modal-body h6`).text(driveText4);
        break;
      case "level5":
        // console.log('bac1');
        $(`#exampleModalLongTitle`).text(levelText5);
        $(`#modal-bac`).text(`血酒濃度：${bacLevel5} %`);
        $(`.modal-body .info .level5`).show();
        $(`.modal-body h6`).text(driveText5);
        break;
    }
  })
  // mk 以上尚待重構
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
    $('#water-level').removeClass()
    $('#water-level').addClass('level_1')
  });
  
  $('#level2').on('click', function() {
    $('#water-level').removeClass()
    $('#water-level').addClass('level_2')
  });
  
  $('#level3').on('click', function() {
    $('#water-level').removeClass()
    $('#water-level').addClass('level_3')
  });
  
  $('#level4').on('click', function() {
    $('#water-level').removeClass()
    $('#water-level').addClass('level_4')
  });
  
  $('#level5').on('click', function() {
    $('#water-level').removeClass()
    $('#water-level').addClass('level_5')
  });

});