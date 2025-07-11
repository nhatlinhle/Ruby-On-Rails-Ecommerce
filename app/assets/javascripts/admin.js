
console.log("ADMIN loaded")
$(document).ready(function() {
  $('.alert').each(function() {
    var $alert = $(this);
    setTimeout(function() {
      $alert.addClass('fade').removeClass('show');
      setTimeout(function() {
        $alert.remove();
      }, 500);
    }, 3000);
  });
});
