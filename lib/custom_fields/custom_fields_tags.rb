module CustomFields
  module CustomFieldsTags
  
    include Radiant::Taggable
    class TagError < StandardError; end

    tag 'custom_fields' do |tag|
      page = tag.locals.page
      tag.locals.custom_fields = page.custom_fields.find_by_name(tag.attr["name"]) rescue nil if tag.attr['name']
      tag.expand
    end
  
    desc %{
      Iterates through all the custom fields in the current page.
      The @name@ attribute is not required on any nested custom fields tags.

      *Usage*:

      <pre><code>
        <r:custom_fields:each [order="asc|desc"] [by="name|value|created_at..."] [limit=0][offset=0]>
          <r:value />
        </r:custom_fields:each>
      </code></pre>
    }
    tag 'custom_fields:each' do |tag|
      page = tag.locals.page
      output = []
      order = tag.attr["order"] || "ASC"
      by = tag.attr["by"] || "name"
      limit = tag.attr["limit"] || nil
      offset = tag.attr["offset"] || nil
      page.custom_fields.find(:all, :order =>  [by, order].join(" "), :limit => limit, :offset => offset).each do |cf|
        tag.locals.custom_fields = cf
        output << tag.expand
      end
      output
    end
    
    desc %{
      Renders the value of the custom_field.
      The @name@ attribute is required on this tag or the parent tag.
      Use the @inherit@ attribute to specify that if a page does not have a custom_field by that name, the tag should render the parent's custom_field. By default @inherit@ is set to @false@.
      You can use the @default_value@ attribute to render a default value in case the custom field is unknown. By default @default_value@ is not set.

      *Usage*:

      <pre><code><r:custom_fields:value name="custom_field_name" [default_value="some_value"] [inherit="true"] /></code></pre>
    }
    tag 'custom_fields:value' do |tag|
      raise TagError, "'name' attribute required" unless name = tag.attr['name'] or tag.locals.custom_fields
      default_value = tag.attr["default_value"] || ""
      inherit = tag.attr["inherit"] || false
      
      page = tag.locals.page
      
      cf = tag.locals.custom_fields || page.custom_fields.find(:first, :conditions => {:name => name})
      
      if inherit
        while (cf.nil? and (not page.parent.nil?)) do
          page = page.parent
          cf = page.custom_fields.find(:first, :conditions => {:name => name})
        end
      end
      
      if cf
        cf.value
      else
        default_value.blank? ? "Unknown custom field '#{name}'." : default_value
      end
    end
    
    desc %{
      Renders the containing elements only if the page's custom fields value matches the regular expression given in @pattern@ attribute.
      The @name@ attribute is required on this tag or the parent tag.
      The @pattern@ attribute is required on this tag.
      Use the @inherit@ attribute to specify that if a page does not have a custom_field by that name, the tag should find the parent's custom_field. By default @inherit@ is set to @false@.

      *Usage:*

      <pre><code><r:custom_fields:if_matches name="custom_field_name" pattern="regexp" [inherit="true"]>...</r:custom_fields:if_matches></code></pre>
    }
    tag 'custom_fields:if_matches' do |tag|
      raise TagError.new("'pattern' attribute required") unless pattern = tag.attr['pattern']
      raise TagError.new("'name' attribute required") unless name = tag.attr['name'] or tag.locals.custom_fields
      inherit = tag.attr["inherit"] || false
      
      regexp = Regexp.new(pattern)
      page = tag.locals.page
      
      cf = tag.locals.custom_fields || page.custom_fields.find(:first, :conditions => {:name => name})
      
      if inherit
        while (cf.nil? and (not page.parent.nil?)) do
          page = page.parent
          cf = page.custom_fields.find(:first, :conditions => {:name => name})
        end
      end
      
      if cf && cf.value.match(regexp)
        tag.expand
      end
    end
    
    desc %{
      The opposite of @if_matches@ tag.
      
      <pre><code><r:custom_fields:unless_matches name="custom_field_name" pattern="regexp" [inherit="true"]>...</r:custom_fields:unless_matches></code></pre>
    }
    tag 'custom_fields:unless_matches' do |tag|
      raise TagError.new("'pattern' attribute required") unless pattern = tag.attr['pattern']
      raise TagError.new("'name' attribute required") unless name = tag.attr['name'] or tag.locals.custom_fields
      inherit = tag.attr["inherit"] || false
      
      regexp = Regexp.new(pattern)
      page = tag.locals.page
      
      cf = tag.locals.custom_fields || page.custom_fields.find(:first, :conditions => {:name => name})
      
      if inherit
        while (cf.nil? and (not page.parent.nil?)) do
          page = page.parent
          cf = page.custom_fields.find(:first, :conditions => {:name => name})
        end
      end
      
      unless cf && cf.value.match(regexp)
        tag.expand
      end
    end
  end
end
