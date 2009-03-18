require File.dirname(__FILE__) + '/../spec_helper'

describe CustomField do
  before(:each) do
    @custom_field = CustomField.new
  end

  it "should be valid" do
    @custom_field.should be_valid
  end
end
