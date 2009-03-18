# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class CustomFieldsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/custom_fields"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :custom_fields
  #   end
  # end
  
  def activate
    # admin.tabs.add "Custom Fields", "/admin/custom_fields", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Custom Fields"
  end
  
end
