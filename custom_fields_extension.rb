# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class CustomFieldsExtension < Radiant::Extension
  version "0.1"
  description "An extension that lets you add custom fields to a Radiant page."
  url "http://blog.aissac.ro/radiant/custom-fields-extension/"
  
  define_routes do |map|
    map.resources :custom_fields, :path_prefix => '/admin/pages/:page_id', :controller  => 'admin/custom_fields'
  end
  
  def activate
    Page.send(:include, CustomFields::PageExtensions)
    Page.send(:include, CustomFields::CustomFieldsTags)
    
    admin.page.edit.add :main, "admin/custom_fields/show_custom_fields", :before => "edit_header"
    admin.page.edit.add :popups, "admin/custom_fields/custom_fields_popup"
  end
  
  def deactivate
  end  
end