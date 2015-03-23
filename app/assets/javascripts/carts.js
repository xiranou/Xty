$(function () {

  $('body').on('click', '.cart-form', function(event) {
    event.preventDefault();
    $form = $(this);

    var url;
    var new_target;


    if ($form.data('target') === 'Add to') {
      url = $form.data("addurl");
      new_target = "Remove from";
    } else{
      url = $form.data("removeurl");
      new_target = "Add to";
    }

    $.ajax({
      url: url,
      type: 'put'
    })
    .done(function(data) {
      $('.cart-count').html(data);
      $form.find(':submit').val(new_target);
      $form.data('target', new_target);
    });
  });

  $('body').on('click', '.cart-remove-button', function(event) {
    event.preventDefault();
    $link = $(this);
    $.ajax({
      url: $link.data("targeturl"),
      type: 'Put',
      dataType: 'json'
    })
    .done(function(count) {
      $('.cart-count').html(count);
      $link.closest('.product-in-cart').slideUp(400);
    });
  });


});