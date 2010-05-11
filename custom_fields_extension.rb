# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class CustomFieldsExtension < Radiant::Extension
  version "0.8" #this version is compatible with Radiant 0.8
  description "An extension that lets you add custom fields to a Radiant page."
  url "http://blog.aissac.ro/radiant/custom-fields-extension/"
  
  define_routes do |map|
    map.resources :custom_fields, :path_prefix => '/admin/pages/:page_id', :controller  => 'admin/custom_fields'
  end
  
  def activate
    Page.send(:include, CustomFields::PageExtensions)
    Page.send(:include, CustomFields::CustomFieldsTags)
    Admin::PagesController.class_eval { include CustomFields::AddAssets }
    
    admin.page.edit.add :main, "admin/custom_fields/show_custom_fields", :before => "edit_header"
    admin.page.edit.add :main, "admin/custom_fields/custom_fields_popup", :before => "edit_buttons"
  end
  
  def deactivate
    # admin.tabs.remove "Custom Fields"
  end
  
end