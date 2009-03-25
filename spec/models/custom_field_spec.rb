require File.dirname(__FILE__) + '/../spec_helper'

describe CustomField do
  dataset :custom_fields
  
  describe "validations" do
    
    it "should be valid" do
      create_custom_field
      @cf.should be_valid
    end
    
    [:name, :value, :page_id].each do |att|
      it "requires #{att} attribute" do
        lambda do
          create_custom_field(att => nil)
          @cf.errors.on(att).should_not be_nil
        end.should_not change(CustomField, :count)
      end
    end
    
    it "requires 'name' attribute to be unique withi 'page_id' scope" do
      lambda do
        create_custom_field(:name => 'first_cf', :page_id => pages(:first).id)
        @cf.errors.on(:name).should_not be_nil
      end.should_not change(CustomField, :count)
    end
  end
  
  describe "methods" do
    
    it "find the assignable custom_fields" do
      
    end
    
  end

  private
    def create_custom_field(options = {})
      @cf = CustomField.new({:name => "test_name", :value => "test_value", :page_id => '1'}.merge(options))
      @cf.save
      @cf
    end

end
