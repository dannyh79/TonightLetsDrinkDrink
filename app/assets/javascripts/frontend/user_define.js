$(document).on('turbolinks:load', function () {
    // 隱藏調酒內容區塊(如果沒有內容的話)
    if ($('.calc-drinks-mini').children('.form-group').length > 0) {
        $('.user_define-form').removeClass('d-none');
    }
});