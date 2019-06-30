$(document).on('turbolinks:load', function () {
    if ($('#success_explanation h2').text() != "" || ($('#error_explanation ul li').text() != "")) {
        $('#success_explanation').addClass('success_message');
    }
    if (($('#error_explanation h2').text() != "") || ($('#error_explanation ul li').text() != "")) {
        $('#error_explanation').addClass('success_message');
    }
});