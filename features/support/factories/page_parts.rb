Factory.define(:page_part) do |f|
  f.sequence(:name){ |i| "Page Part #{i}"}
  f.content "Some generic content"
  f.association :page, :factory => :generic_page
end

Factory.define(:textile_page_part, :parent => :page_part) do |f|
  f.filter_id "Textile"
  f.content "Some *Textile* content."
end

Factory.define(:markdown_page_part, :parent => :page_part) do |f|
  f.filter_id "Markdown"
  f.content "Some **Markdown** content."
end
