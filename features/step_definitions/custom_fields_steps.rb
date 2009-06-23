Given /^I am logged in as admin$/ do
  Given "I navigate to \"the welcome page\""
    And "I enter in \"user_login\" field \"admin\""
    And "I enter in \"user_password\" field \"password\""
    And "I click the \"Login\" button"
end

Given /^A Custom Field "([^\"]*)" with "([^\"]*)" exists on "([^\"]*)"$/ do |cf_name, cf_value, page|
  Given "I click the \"#{page}\" link"
    And "I click the \"Show Custom Fields\" link"
    And "I click the \"Add new custom field\" link in the popup"
    And "I click the \"Enter new\" link in the popup"
    And "I enter in \"custom_field_name\" field \"#{cf_name}\" in the popup"
    And "I enter in \"custom_field_value\" field \"#{cf_value}\" in the popup"
    And "I click the \"Add Custom Field\" button in the popup"
   When "I click the \"Close\" link"
    And "I click the \"Save Changes\" button"
end