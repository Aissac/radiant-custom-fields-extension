require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::CustomFieldsController do
  dataset :users, :pages, :custom_fields

  before do
    login_as :developer
    @page = pages(:first)
    Page.stub!(:find).and_return(@page)
  end

  describe "handling GET index" do

    before do
      @cfs = [custom_fields(:first_cf), custom_fields(:second_cf)]
      @page.stub!(:custom_fields).and_return(@cfs)
    end

    def do_get
      get :index, :page_id => @page.id
    end
    
    it "is successful" do
      do_get
      response.should be_success
    end
    
    it "renders the index template" do
      do_get
      response.should render_template(:index)
    end
    
    it "finds the page" do
      Page.should_receive(:find).with(@page.id.to_s).and_return(@page)
      do_get
    end
    
    it "finds the custom_fields assigned to the page" do
      @page.should_receive(:custom_fields).and_return(@cfs)
      do_get
    end
    
    it "finds the custom_fields assignable to the page" do
      CustomField.should_receive(:find_assignable_cf).with(@page.id.to_s).and_return("third_cf")
      do_get
    end
    
    it "assigns the found custom_fields to the view" do
      do_get
      assigns[:custom_fields].should == @cfs
    end
    
    it "includes custom_fields javascripts" do
      controller.should_receive(:include_javascript).with('admin/custom_fields_iframe')
      do_get
    end
    
    it "includes custom_fields stylesheets" do
      controller.should_receive(:include_stylesheet).with('admin/custom_fields')
      do_get
    end
  end
  
  describe "handling POST create" do
    
    before do
      @cf = mock_model(CustomField, :save => true)
      CustomField.stub!(:new).and_return(@cf)
      @cf.stub!(:name=)
    end
    
    def do_post(options={})
      post :create, :page_id => @page.id, :custom_field => options
    end
    
    it "creates a new custom field from params" do
      CustomField.should_receive(:new).with("name" => 'test_name')
      do_post(:name => 'test_name')
    end
    
    it "redirects on success" do
      do_post
      response.should be_redirect
    end
    
    it "redirects on failure" do
      @errors = mock("errors")
      @cf.stub!(:errors).and_return(@errors)
      @full_messages = mock("full_messages")
      @errors.stub!(:full_messages).and_return(@full_messages)
      @full_messages.stub!(:join)
      @cf.should_receive(:save).and_return(false)
      do_post
      response.should be_redirect
    end
  end

   
   
  describe "handling PUT update" do
    
    before do
      @cf = mock_model(CustomField)
      CustomField.stub!(:find).and_return(@cf)
      @cf.stub!(:update_attributes).and_return(true)
    end
    
    def do_put(options={})
      put :update, :page_id => @page.id, :id => @cf.id, :custom_field => options
    end
    
    it "finds the custom_field" do
      CustomField.should_receive(:find).with(@cf.id.to_s).and_return(@cf)
      do_put
    end
    
    it "redirects on success" do
      do_put
      response.should be_redirect
    end
    
    it "edits the custom_field from params" do
      @cf.should_receive(:update_attributes).with("name" => "test").and_return(true)
      do_put(:name => "test")
    end
    
    it "redirects on failure" do
      @errors = mock("errors")
      @cf.stub!(:errors).and_return(@errors)
      @full_messages = mock("full_messages")
      @errors.stub!(:full_messages).and_return(@full_messages)
      @full_messages.stub!(:join)
      @cf.should_receive(:update_attributes).and_return(false)
      do_put
      response.should be_redirect
    end
  end
  
  describe "handling DELETE destroy" do
    
    before do
      @cf = mock_model(CustomField)
      CustomField.stub!(:find).and_return(@cf)
      @cf.stub!(:destroy)
    end
    
    def do_delete
      delete :destroy, :page_id => @page.id, :id => @cf.id
    end
    
    it "redirects on success" do
      do_delete
      response.should be_redirect
    end
    
    it "finds the coresponding custom_field" do
      CustomField.should_receive(:find).with(@cf.id.to_s).and_return(@cf)
      do_delete
    end
    
    it "deletes the selected custom_field" do
      @cf.should_receive(:destroy)
      do_delete
    end
  end
end
