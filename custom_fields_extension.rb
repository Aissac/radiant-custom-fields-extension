# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class CustomFieldsExtension < Radiant::Extension
  version "0.9" # this version is compatible with Radiant 0.9RC2
  description "An extension that lets you add custom fields to a Radiant page."
  url "http://blog.aissac.ro/radiant/custom-fields-extension/"
  
  def activate
    Page.send(:include, CustomFields::PageExtensions)
    Page.send(:include, CustomFields::CustomFieldsTags)
    
    admin.page.edit.add :main, "admin/custom_fields/show_custom_fields", :before => "edit_header"
    admin.page.edit.add :popups, "admin/custom_fields/custom_fields_popup"
  end
  
  def deactivate
  end  
end
