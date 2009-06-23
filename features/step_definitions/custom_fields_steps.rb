Given /^I am logged in as admin$/ do
  Given "I navigate to \"the welcome page\""
    And "I enter in \"user_login\" field \"admin\""
    And "I enter in \"user_password\" field \"password\""
    And "I click the \"Login\" button"
end

Then /^I must see "([^\"]*)" in the iframe$/ do |text|
  cf_frame.text.gsub(/\n/, ' ').gsub(/\s+/, ' ').should include(text)
end

Given /^I click the "([^\"]*)" link in the iframe$/ do |lnk|
  link = cf_frame.link(:text, lnk)
  link.click
  browser.wait
end

When /^I enter in "([^\"]*)" field "([^\"]*)" in the iframe$/ do |field, value|
  cf_frame.text_field(:id, field).set(value)
end

When /^I enter in "([^\"]*)" value "([^\"]*)" in the iframe$/ do |field_value, value|
  cf_frame.text_field(:value, field_value).set(value)
end

When /^I click the "([^\"]*)" button in the iframe$/ do |button|
  cf_frame.button(:value, button).click
  browser.wait
end


Given /^A Custom Field "([^\"]*)" with "([^\"]*)" exists on "([^\"]*)"$/ do |cf_name, cf_value, page|
  Given "I click the \"#{page}\" link"
    And "I click the \"Show Custom Fields\" link"
    And "I click the \"Add new custom field\" link in the iframe"
    And "I click the \"Enter new\" link in the iframe"
    And "I enter in \"custom_field_name\" field \"#{cf_name}\" in the iframe"
    And "I enter in \"custom_field_value\" field \"#{cf_value}\" in the iframe"
    And "I click the \"Add Custom Field\" button in the iframe"
   When "I click the \"Close\" link"
    And "I click the \"Save Changes\" button"
end

Given /^I select the "([^\"]*)" option from "([^\"]*)" in the iframe$/ do |value, ddl|
  cf_frame.select_list(:id, ddl).select(value)
end