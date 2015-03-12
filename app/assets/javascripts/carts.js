$(function () {
  $('body').on('click', '.cart-button', function(event) {
    event.preventDefault();
    $button = $(this);

    var url;
    var new_target;


    if ($button.data('target') === 'Add to') {
      url = $button.data("addurl");
      new_target = "Remove from";
    } else{
      url = $button.data("removeurl");
      new_target = "Add to";
    }

    $.ajax({
      url: url,
      type: 'put'
    })
    .done(function(data) {
      $('.cart-count').html(data);
      $button.find('span').html(new_target);
      $button.data('target', new_target);
    });

  });
});