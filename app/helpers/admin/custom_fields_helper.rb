module Admin::CustomFieldsHelper
  
  def show_flash_message
    [:notice, :error, :success].map do |f|
      content_tag :div, flash[f], :class => "flash #{f}" if flash[f]
    end
  end
  
end
