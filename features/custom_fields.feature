Feature: Manipulation Custom Fields
  In order manipulate custom fields
  As an admin
  I want to be able to create, update and delete custom fields
  
  Background:
    Given I am logged in as admin  
    
    Scenario: Creating custom fields
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the "Add new custom field" link in the popup
         And I click the "Enter new" link in the popup
         And I enter in "custom_field_name" field "test custom field" in the popup
         And I enter in "custom_field_value" field "test custom field value" in the popup
         And I click the "Add Custom Field" button in the popup
         And I wait 1 second
        Then I must see "The Custom Field was succesfully created." in the popup
    
    Scenario: Creating a custom field that already exists on another page
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the "Add new custom field" link in the popup
         And I select the "third_cf" option from "select_name" in the popup
         And I enter in "custom_field_value" field "existing cf value on first" in the popup
         And I click the "Add Custom Field" button in the popup
         And I wait 1 second
        Then I must see "The Custom Field was succesfully created." in the popup
      
    Scenario: Updating an existing custom field
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I enter in "first_cf" value "new first_cf" in the popup
         And I click the "Update" button in the popup
         And I wait 1 second
        Then I must see "The Custom Field was succesfully updated." in the popup
     
    Scenario: Deleting an existing custom field
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the Delete link in the popup and confirm the dialog
         And I wait 1 second
        Then I must see "The Custom Field was succesfully deleted." in the popup
