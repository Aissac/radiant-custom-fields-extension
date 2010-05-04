Given /^I am logged in as admin$/ do
  When %Q{I am on the welcome page}
   And %Q{I fill in "Username or E-mail Address" with "admin"}
   And %Q{I fill in "Password" with "password"}
   And %Q{I press "Login"}
end