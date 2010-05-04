Feature: Manipulation Custom Fields
  In order manipulate custom fields
  As an admin
  I want to be able to create, update and delete custom fields
  
  Background:
    Given I am logged in as admin
    
    @javascript
    Scenario: Creating custom fields
        When I follow "First"
         And I follow "Show Custom Fields"
         And I follow "Add new custom field" within frame "CFframe"
         And I follow "Enter new" within frame "CFframe"
         And I fill in "custom_field_name" with "test custom field" within frame "CFframe"
         And I fill in "custom_field_value" with "test custom field value" within frame "CFframe"
         And I press "Add Custom Field" within frame "CFframe"
        Then I should see "The Custom Field was succesfully created." within frame "CFframe"
    
    @javascript
    Scenario: Creating a custom field that already exists on another page
        When I follow "First"
         And I follow "Show Custom Fields"
         And I follow "Add new custom field" within frame "CFframe"
         And I select "a_cf_on_another_page" from "select_name" within frame "CFframe"
         And I fill in "custom_field_value" with "some value" within frame "CFframe"
         And I press "Add Custom Field" within frame "CFframe"
        Then I should see "The Custom Field was succesfully created." within frame "CFframe"
    
    @javascript
    Scenario: Updating an existing custom field
        When I follow "First"
         And I follow "Show Custom Fields"
         And I fill in "custom_field_name" with "new_cf_on_first_page" within frame "CFframe"
         And I press "Update" within frame "CFframe"
        Then I should see "The Custom Field was succesfully updated." within frame "CFframe"
    
    @javascript
    Scenario: Deleting an existing custom field
        When I follow "First"
         And I follow "Show Custom Fields"
         And I follow "Delete" within frame "CFframe"
        Then I should see "The Custom Field was succesfully deleted." within frame "CFframe"
