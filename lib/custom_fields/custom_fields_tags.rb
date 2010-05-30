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
      Iterates through all the custom fields in the current page.  The @name@ attribute is not required on any nested custom fields tags.

      *Usage*:

      <pre><code><r:custom_fields:each 
       [order="asc|desc"]
       [by="name|value|created_at..."]
       [limit=0]
       [offset=0]
       >
         <r:value />
      </r:custom_fields:each></code></pre>
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
      Renders the value of the custom_field. The @name@ attribute is required on this tag or the parent tag. You can use the @default_value@ attribute to render a default value in case the custom field is unknown.

      *Usage*:

      <pre><code><r:custom_fields:value name="custom_field_name"
       [default_value="some_value"]/></code></pre>
    }
    tag 'custom_fields:value' do |tag|
      raise TagError, "'name' attribute required" unless name = tag.attr['name'] or tag.locals.custom_fields
      page = tag.locals.page
      default_value = tag.attr["default_value"] || ""
      cf = tag.locals.custom_fields || page.custom_fields.find(:first, :conditions => {:name => name})
      if cf
        cf.value
      else
        default_value.blank? ? "Unknown custom field '#{name}'." : default_value
      end
    end
    
    
    desc %{
      Renders the containing elements only if the page's custom fields value matches the regular expression given in @pattern@ attribute. The @name@ attribute is required on this tag or the parent tag.

      *Usage:*

      <pre><code><r:if_matches pattern="regexp" name="custom_field_name">
       ...</r:if_matches></code></pre>
    }
    tag 'custom_fields:if_matches' do |tag|
      raise TagError.new("'pattern' attribute required") unless pattern = tag.attr['pattern']
      raise TagError.new("'name' attribute required") unless name = tag.attr['name'] or tag.locals.custom_fields
      regexp = Regexp.new(pattern)
      cf = tag.locals.custom_fields || tag.locals.page.custom_fields.find(:first, :conditions => {:name => name})
      if cf.value.match(regexp)
        tag.expand
      end
    end
    
    desc %{
      The opposite of @if_matches@ tag.
      
      <pre><code><r:unless_matches pattern="regexp" name="custom_field_name">
       ...</r:unless_matches></code></pre>
    }
    
    tag 'custom_fields:unless_matches' do |tag|
      raise TagError.new("'pattern' attribute required") unless pattern = tag.attr['pattern']
      raise TagError.new("'name' attribute required") unless name = tag.attr['name'] or tag.locals.custom_fields
      regexp = Regexp.new(pattern)
      cf = tag.locals.custom_fields || tag.locals.page.custom_fields.find(:first, :conditions => {:name => name})
      unless cf.value.match(regexp)
        tag.expand
      end
    end
  end
end