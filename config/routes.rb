ActionController::Routing::Routes.draw do |map|
  map.resources :custom_fields, :path_prefix => '/admin/pages/:page_id', :controller  => 'admin/custom_fields'
end