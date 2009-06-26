Feature: Manipulation Custom Fields
  In order manipulate custom fields
  As an admin
  I want to be able to create, update and delete custom fields
  
  Background:
    Given I am logged in as admin  
    
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
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the "Add new custom field" link in the iframe
         And I select the "a_cf_on_another_page" option from "select_name" in the iframe
         And I enter in "custom_field_value" field "some value" in the iframe
         And I click the "Add Custom Field" button in the iframe
         And I wait 1 second
        Then I must see "The Custom Field was succesfully created." in the iframe
      
    Scenario: Updating an existing custom field
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I enter in "a_cf_on_first_page" value "new_cf_on_first_page" in the iframe
         And I click the "Update" button in the iframe
         And I wait 1 second
        Then I must see "The Custom Field was succesfully updated." in the iframe
     
    Scenario: Deleting an existing custom field
        When I click the "First" link
         And I click the "Show Custom Fields" link
         And I click the Delete link in the iframe and confirm the dialog
         And I wait 1 second
        Then I must see "The Custom Field was succesfully deleted." in the iframe
