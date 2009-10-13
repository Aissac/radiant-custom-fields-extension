Event.observe(window, 'load', function () {
  Event.observe('enter_new_custom_field', 'click', function () {
    $$("select.select_name")[0].hide();
    $("enter_new_custom_field").hide();
    $$("input.tb_name")[0].show();
    $("cancel_enter_new_custom_field").show();
  });
  Event.observe('cancel_enter_new_custom_field', 'click', function () {
    $$("select.select_name")[0].show();
    $("enter_new_custom_field").show();
    $$("input.tb_name")[0].hide();
    $("cancel_enter_new_custom_field").hide();
  });
  Event.observe('add_new_custom_field_link', 'click', function () {
    $("add_new_custom_field_div").show();
    $("add_new_custom_field_link").hide();
  });
  Event.observe('cancel_new_custom_field', 'click', function () {
    $("add_new_custom_field_div").hide();
    $("add_new_custom_field_link").show();
  })
});