$(document).on('turbolinks:load', function() {

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