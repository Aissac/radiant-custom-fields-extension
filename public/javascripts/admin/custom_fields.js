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
  Event.observe('add_cf_link', 'click', function () {
    $("add_cf_div").show();
    $("add_cf_link").hide();
  });
  Event.observe('cancel_new_cf', 'click', function () {
    $("add_cf_div").hide();
    $("add_cf_link").show();
  })
});