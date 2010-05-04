Factory.define(:layout) do |f|
  f.sequence(:name) { |i| "Layout #{i}"}
  f.content "<html><head><title><r:title /></title></head><body><r:content /></body></html>"
  f.content_type "text/html"
end
