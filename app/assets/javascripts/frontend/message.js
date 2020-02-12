$(document).on('turbolinks:load', () => {
  if ($('#success_explanation p').text() !== '') {
    $('#success_explanation').addClass('success_message');
  }
  if (($('#error_explanation p').text() !== '')) {
    $('#error_explanation').addClass('error_message');
  }
  if (($('#error_message p').text() !== '')) {
    $('#error_message').addClass('error_message');
  }
});
