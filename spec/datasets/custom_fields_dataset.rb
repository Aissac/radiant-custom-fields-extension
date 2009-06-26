class CustomFieldsDataset < Dataset::Base
  uses :pages
  def load
    create_record :custom_field, :a_cf_on_first_page, 
      {:name => 'a_cf_on_first_page', :value => 'a_cf_on_first_page_value', :page_id => pages(:first).id}
      
    create_record :custom_field, :another_cf_on_first_page,
      {:name => 'another_cf_on_first_page',:value => 'another_cf_on_first_page_value',:page_id => pages(:first).id}
      
    create_record :custom_field, :a_cf_on_another_page, 
      {:name => 'a_cf_on_another_page', :value => 'a_cf_on_another_page_value', :page_id => pages(:another).id}
  end
end