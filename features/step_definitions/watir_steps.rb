Given /^I navigate to the "([^\"]*)" page$/ do |page_name|
  browser.goto("http://localhost:3001#{path_to(page_name)}")
end

Given /^I wait for the page to load$/ do
  browser.wait
end

Given /^I wait (\d+) seconds?$/ do |seconds|
  sleep seconds.to_i
end
 
Given /^I enter in "([^\"]*)" field "([^\"]*)"$/ do |field, value|
  browser.text_field(:id, field).set(value)
end
 
Given /^I select the "([^\"]*)" option from "([^\"]*)"/ do |value, ddl|
  browser.select_list(:id, ddl).select(value)
end
 
Given /^I click the "([^\"]*)" button$/ do |but|
  browser.button(:value, but).click
  browser.wait
end
 
Given /^I click the "([^\"]*)" link$/ do |lnk|
  link = browser.link(:text, lnk)
  link.click
  browser.wait
end
 
Given /^I click the link with id "([^\"]*)"$/ do |lnk|
  browser.link(:id, lnk).click
  browser.wait
end
 
Then /^I must see "([^\"]*)"$/ do |text|
  browser.text.gsub(/\n/, ' ').gsub(/\s+/, ' ').should include(text)
end
 
Then /^I must not see "([^\"]*)"$/ do |text|
  browser.text.gsub(/\n/, ' ').gsub(/\s+/, ' ').should_not include(text)
end
