Feature: Manipulation Custom Fields
  In order manipulate custom fields
  As an admin
  I want to be able to create, update and delete custom fields
  
  Background:
    Given I am logged in as admin  
    
    Scenario: Opening Custom Fields iFrame
        When I click the "First" link
         And I click the "Show Custom Fields" link
       Then I must see "Custom fields:" in the iframe
    
    Scenario: Creating custom fields
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the "Add new custom field" link in the iframe
         And I click the "Enter new" link in the iframe
         And I enter in "custom_field_name" field "test custom field" in the iframe
         And I enter in "custom_field_value" field "test custom field value" in the iframe
         And I click the "Add Custom Field" button in the iframe
         And I wait 1 second
        Then I must see "The Custom Field was succesfully created." in the iframe
    
    Scenario: Creating a custom field that already exists on another page
       Given A Custom Field "existing custom field" with "existing custom field value" exists on "Another"
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the "Add new custom field" link in the iframe
         And I select the "existing custom field" option from "select_name" in the iframe
         And I enter in "custom_field_value" field "existing cf value on first" in the iframe
         And I click the "Add Custom Field" button in the iframe
         And I wait 1 second
        Then I must see "The Custom Field was succesfully created." in the iframe
      
    Scenario: Updating an existing custom field
       Given A Custom Field "old custom field" with "old custom field value" exists on "First"
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I enter in "old custom field" value "new custom field" in the iframe
         And I click the "Update" button in the iframe
         And I wait 1 second
        Then I must see "The Custom Field was succesfully updated." in the iframe
     
    Scenario: Deleting an existing custom field
       Given A Custom Field "to delete custom field" with "to delete custom field value" exists on "First"
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the "Delete" link in the iframe
         And I wait 1 second
        Then I must see "The Custom Field was succesfully deleted." in the iframe
