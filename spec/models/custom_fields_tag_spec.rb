require 'spec_helper'

describe "Custom Fields" do  
  dataset :pages, :custom_fields
  
  before do
    @page = pages(:first)
  end
  
  describe "<r:custom_fields:value />" do
    it "<r:custom_fields:value /> renders the value" do
      @page.should render("<r:custom_fields:value name='a_cf_on_first_page' />").as("a_cf_on_first_page_value") 
    end
  
    it "<r:custom_fields name='first_cf'><r:value /></r:custom_fields> renders value if 'name' attribute is on parent tag" do
      @page.should render("<r:custom_fields name='a_cf_on_first_page'><r:value /></r:custom_fields>").as("a_cf_on_first_page_value")
    end
  
    it "errors with 'name attribute required'" do
      @page.should render("<r:custom_fields:value />").with_error("'name' attribute required")
    end
  
    it "errors with 'name attribute required' if 'name' attribute is not on parent tag either" do
      @page.should render("<r:custom_fields><r:value /></r:custom_fields>").with_error("'name' attribute required")
    end
  
    it "<r:custom_fields:value name='test_cf' default_value='default_cf_value' /> renders the default value" do
      @page.should render("<r:custom_fields:value name='test_cf' default_value='default_cf_value' />").as("default_cf_value")
    end
  end

  describe "<r:custom_fields:if_matches>...</r:custom_fields:if_matches>" do
    it "<r:custom_fields:if_matches>...</r:custom_fields:if_matches> renders the contained block if the custom_field value matches the pattern" do
      @page.should render("<r:custom_fields:if_matches pattern='first' name='a_cf_on_first_page'>true</r:custom_fields:if_matches>").as("true")
    end
  
    it "<r:custom_fields:if_matches>...</r:custom_fields:if_matches> renders the contained block if the custom_field value matches the pattern and the 'name' attribute is on parent tag" do
      @page.should render("<r:custom_fields name='a_cf_on_first_page'><r:if_matches pattern='first'>true</r:if_matches></r:custom_fields>").as("true")
    end
  
    it "errors with 'pattern' attribute not found" do
      @page.should render("<r:custom_fields:if_matches>true</r:custom_fields:if_matches>").with_error("'pattern' attribute required")
    end
  
    it "errors with 'name' attribute required" do
      @page.should render("<r:custom_fields:if_matches pattern='test'>true</r:custom_fields:if_matches>").with_error("'name' attribute required")
    end
    
    it "errors with 'name' attribute required if 'name' not found on parent tag" do
      @page.should render("<r:custom_fields><r:if_matches pattern='test'>true</r:if_matches></r:custom_fields>").with_error("'name' attribute required")
    end
  end
  
  describe "<r:custom_fields:unless_matches>...</r:custom_fields:unless_matches>" do
    it "<r:custom_fields:unless_matches>...</r:custom_fields:unless_matches> renders the contained block if custom_field value does not match the pattern" do
      @page.should render("<r:custom_fields:unless_matches pattern='second' name='a_cf_on_first_page'>true</r:custom_fields:unless_matches>").as("true")    
    end
    
    it "<r:custom_fields:unless_matches>...</r:custom_fields:unless_matches> renders the contained block if the custom_field value does not match the pattern and the 'name' attribute is on parent tag" do
      @page.should render("<r:custom_fields name='another_cf_on_first_page'><r:unless_matches pattern='second'>true</r:unless_matches></r:custom_fields>").as("true")
    end
    
    it "errors with 'pattern' attribute not found" do
      @page.should render("<r:custom_fields:unless_matches>true</r:custom_fields:unless_matches>").with_error("'pattern' attribute required")
    end
    
    it "errors with 'name' attribute required" do
      @page.should render("<r:custom_fields:unless_matches pattern='test'>true</r:custom_fields:unless_matches>").with_error("'name' attribute required")
    end
    
    it "errors with 'name' attribute required if 'name' not found on parent tag" do
      @page.should render("<r:custom_fields><r:unless_matches pattern='test'>true</r:unless_matches></r:custom_fields>").with_error("'name' attribute required")
    end
  end
  
  describe "<r:custom_fields:each>...</r:custom_fields:each>" do
    it "<r:custom_fields:each>...</r:custom_fields:each> renders the custom_fields of the current page" do
      @page.should render(page_custom_fields_each_tag).as("a_cf_on_first_page_value another_cf_on_first_page_value ")
    end
    
    it "limits the number of custom_fields when given the limit attribute" do
      @page.should render(page_custom_fields_each_tag(%{limit='1'})).as("a_cf_on_first_page_value ")
    end
    
    it "limits and offsets the custom_fields when given limit and offset attributes" do
      @page.should render(page_custom_fields_each_tag(%{limit='1' offset='1'})).as("another_cf_on_first_page_value ")
    end
    
    it "changes the sort order when given the order attribute" do
      @page.should render(page_custom_fields_each_tag(%{order='DESC'})).as("another_cf_on_first_page_value a_cf_on_first_page_value ")
    end
    
    it "sorts by the given attribute" do
      @page.should render(page_custom_fields_each_tag(%{by='value'})).as("a_cf_on_first_page_value another_cf_on_first_page_value ")
    end
    
    it "sort by the 'by' attribute according to the 'order' attribute" do
      @page.should render(page_custom_fields_each_tag(%{by='value' order='DESC'})).as("another_cf_on_first_page_value a_cf_on_first_page_value ")
    end
  end
  
  def page_custom_fields_each_tag(attr = nil)
    attr = ' ' + attr unless attr.nil?
    "<r:custom_fields:each#{attr}><r:value /> </r:custom_fields:each>"
  end
end