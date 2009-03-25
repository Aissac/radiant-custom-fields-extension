class CustomFieldsDataset < Dataset::Base
  uses :pages
  def load
    create_record :custom_field, :first_cf, {:name => 'first_cf', :value => 'first_cf_value', :page_id => pages(:first).id}
    create_record :custom_field, :second_cf,{:name => 'second_cf',:value => 'second_cf_value',:page_id => pages(:first).id}
    create_record :custom_field, :third_cf, {:name => 'third_cf', :value => 'third_cf_value', :page_id => pages(:another).id}
  end
end