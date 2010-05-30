class Admin::CustomFieldsController < ApplicationController
  layout 'custom_fields'
  before_filter :find_page
  before_filter :attach_assets, :find_all_assignable_custom_fields, :only => [:index]
  
  def index
    @custom_fields = @page.custom_fields
  end
  
  def create
    @custom_field = CustomField.new(params[:custom_field])
    params[:select_name].blank? ? @custom_field.name = params[:custom_field][:name] : @custom_field.name = params[:select_name]
    if @custom_field.save
      flash[:success] = t('custom_fields_controller.flash_success.create')
      redirect_to custom_fields_path(@page)
    else
      flash[:error] = "#{t('custom_fields_controller.flash_error.create')} #{@custom_field.errors.full_messages.join(", ")}"
      
      redirect_to custom_fields_path(@page)
    end
  end
  
  def update
    @custom_field = CustomField.find(params[:id])
    if @custom_field.update_attributes(params[:custom_field])
      flash[:success] = t('custom_fields_controller.flash_success.update')
      redirect_to custom_fields_path(@page)
    else
      flash[:error] = "#{t('custom_fields_controller.flash_error.update')} #{@custom_field.errors.full_messages.join(", ")}"
      redirect_to custom_fields_path(@page)
    end
  end
  
  def destroy
    @custom_field = CustomField.find(params[:id])
    @custom_field.destroy
    flash[:success] = t('custom_fields_controller.flash_success.destroy')
    redirect_to custom_fields_path(@page)
  end
  
  private
    def find_page
      @page = Page.find(params[:page_id])
    end
    
    def find_all_assignable_custom_fields
      @assignable_custom_fields = CustomField.find_assignable_custom_fields(params[:page_id])
    end
    
    def attach_assets
      include_javascript "admin/prototype"
      include_javascript "admin/custom_fields"
      include_stylesheet "admin/custom_fields"
    end
end