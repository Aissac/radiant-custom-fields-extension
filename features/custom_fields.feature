Feature: Manipulation Custom Fields
  In order manipulate custom fields
  As an admin
  I want to be able to create, update and delete custom fields
  
  Background:
    Given the page structure exists
      And I am logged in as "admin"
      
    @javascript
    Scenario: Creating custom fields
       When I follow "First"
        And I follow "Show Custom Fields"
        And I follow "Add new custom field" within frame "CFframe"
        And I follow "Enter new" within frame "CFframe"
        And I fill in "custom_field_name" with "test custom field" within frame "CFframe"
        And I fill in "custom_field_value" with "test custom field value" within frame "CFframe"
        And I press "Add Custom Field" within frame "CFframe"
       Then I should see "The custom field was successfully created!" within frame "CFframe"
        And a custom field should exist with name: "test custom field", value: "test custom field value", page: page "fp"
    
    @javascript
    Scenario: Creating a custom field that already exists on another page
      Given a custom field exists with name: "custom field on another page", value: "value", page: page "sp"
       When I follow "First"
        And I follow "Show Custom Fields"
        And I follow "Add new custom field" within frame "CFframe"
        And I select "custom field on another page" from "select_name" within frame "CFframe"
        And I fill in "custom_field_value" with "some value" within frame "CFframe"
        And I press "Add Custom Field" within frame "CFframe"
       Then I should see "The custom field was successfully created!" within frame "CFframe"
        And a custom field should exist with name: "custom field on another page", value: "some value", page: page "fp"
    
    @javascript
    Scenario: Updating an existing custom field
      Given a custom field "cf" exists with name: "custom field on page", value: "somw value", page: page "fp"
       When I follow "First"
        And I follow "Show Custom Fields"
        And I fill in "custom_field_name" with "new_cf_on_first_page" within frame "CFframe" for custom field "cf"
        And I press "Update" within frame "CFframe"
       Then I should see "The custom field was successfully updated!" within frame "CFframe"
    
    @javascript
    Scenario: Deleting an existing custom field
      Given a custom field "cf" exists with name: "custom field on page", value: "somw value", page: page "fp"
       When I follow "First"
        And I follow "Show Custom Fields"
        And I follow "Delete" within frame "CFframe"
       Then I should see "The custom field was successfully removed!" within frame "CFframe"
