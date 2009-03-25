class Admin::CustomFieldsController < ApplicationController
  
  layout 'custom_fields'
  before_filter :find_page, :find_all_custon_fields
  
  def index
    include_javascript "admin/custom_fields_iframe"
    include_stylesheet "admin/custom_fields"  
    @custom_fields = Page.find(params[:page_id]).custom_fields
  end
  
  def create
    @cf = CustomField.new(params[:custom_field])
    params[:select_name].blank? ? @cf.name = params[:custom_field][:name] : @cf.name = params[:select_name]
    if @cf.save
      flash[:success] = "The Custom Field was succesfully created."
      redirect_to custom_fields_path(@page)
    else
      flash[:error] = @cf.errors.full_messages.join(", ")
      redirect_to custom_fields_path(@page)
    end
  end
  
  def update
    @cf = CustomField.find(params[:id])
    if @cf.update_attributes(params[:custom_field])
      flash[:success] = "The Custom Field was succesfully updated."
      redirect_to custom_fields_path(@page)
    else
      flash[:error] = @cf.errors.full_messages.join(", ")
      redirect_to custom_fields_path(@page)
    end
  end
  
  def destroy
    @cf = CustomField.find(params[:id])
    if @cf.destroy
      flash[:success] = "The Custom Field was succesfully deleted."
      redirect_to custom_fields_path(@page)
    else
      flash[:error] = @cf.errors.full_messages.join(", ")
      redirect_to custom_fields_path(@page)
    end
  end
  
  private
    def find_page
      @page = Page.find(params[:page_id])
    end
    
    def find_all_custon_fields
      @cfs = CustomField.find_assignable_cf(params[:page_id])
    end
end