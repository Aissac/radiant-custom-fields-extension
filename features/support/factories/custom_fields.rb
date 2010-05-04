Factory.define(:custom_field) do |f|
  f.sequence(:name) { |i| "Custom Field #{i}"}
  f.value "Custom Field Value"
  f.association :page, :factory => :generic_page
end