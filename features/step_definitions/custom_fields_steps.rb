Given /^I am logged in as admin$/ do
  Given "I navigate to \"the welcome page\""
    And "I enter in \"user_login\" field \"admin\""
    And "I enter in \"user_password\" field \"password\""
    And "I click the \"Login\" button"
end