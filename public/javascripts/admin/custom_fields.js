Event.observe(window, 'load', function () {
  Event.observe("show_custom_fields_link", 'click', function () {
    $("custom_fields").show();
  });
});