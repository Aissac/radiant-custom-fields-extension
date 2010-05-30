require 'spec_helper'

describe CustomField do
  dataset :pages, :custom_fields
  
  #columns
  should_have_column :name, :value, :type => :string
  
  #associations
  should_belong_to :page
  
  #validations
  describe "validations" do
    should_validate_presence_of :name, :value, :page_id
    
    it "requires 'name' attribute to be unique within 'page_id' scope" do
      lambda do
        create_custom_field(:name => 'a_cf_on_first_page', :page_id => pages(:first).id)
        @custom_field.errors.on(:name).should_not be_nil
      end.should_not change(CustomField, :count)
    end
  end
  
  describe "methods" do
    it "find the assignable custom fields" do
      CustomField.find_assignable_custom_fields(pages(:first).id).should == ["a_cf_on_another_page"]
    end
  end

  private
    def create_custom_field(options = {})
      @custom_field = CustomField.new({:name => "test_name", :value => "test_value", :page_id => '1'}.merge(options))
      @custom_field.save
      @custom_field
    end
end
