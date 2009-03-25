module CustomFields
  module CustomFieldsTags
  
    include Radiant::Taggable
    class TagError < StandardError; end

    tag 'custom_field' do |tag|
      page = tag.locals.page
      tag.locals.custom_field = page.custom_field(tag.attr["name"]) rescue nil if tag.attr['name']
      tag.expand
    end
  
    desc %{
      Iterates through all the custom fields in the current page.  The @name@ attribute is not required
      on any nested custom fields tags.

      *Usage*:

      <pre><code>
        <r:custom_field:each [order="asc|desc"] [by="name|value|created_at..."] [limit=0] [offset=0]>
          <r:value />
        </r:custom_field:each>
      </code></pre>
    }
    tag 'custom_field:each' do |tag|
      page = tag.locals.page
      output = []
      order = tag.attr["order"] || "ASC"
      by = tag.attr["by"] || "name"
      limit = tag.attr["limit"] || nil
      offset = tag.attr["offset"] || nil
      page.custom_fields.find(:all, :order =>  [by, order].join(" "), :limit => limit, :offset => offset).each do |cf|
        tag.locals.custom_field = cf
        output << tag.expand
      end
      output
    end
    
    desc %{
      Renders the value of the custom_field. The @name@ attribute is required on this tag or the parent tag.

      *Usage*:

      <pre><code><r:custom_field:value name="custom_field_name" /></code></pre>
    }
    tag 'custom_field:value' do |tag|
      raise TagError, "'name' attribute required" unless name = tag.attr['name'] or tag.locals.custom_field
      page = tag.locals.page
      cf = tag.locals.custom_field || page.custom_fields.find(:first, :conditions => {:name => name})
      cf.value
    end
    
    
    desc %{
      Renders the containing elements only if the page's custom fields value matches the regular expression 
      given in @matches@ attribute. The @name@ attribute is required on this tag or the parent tag.

      *Usage:*

      <pre><code><r:if_matches matches="regexp" name="custom_field_name">...</r:if_matches></code></pre>
    }
    tag 'if_matches' do |tag|
      raise TagError.new("'matches' attribute required") unless matches = tag.attr['matches']
      raise TagError.new("'name' attribute required") unless name = tag.attr['name'] or tag.locals.custom_field
      regexp = Regexp.new tag.attr['matches']
      cf = tag.locals.custom_field || tag.locals.page.custom_fields.find(:first, :conditions => {:name => name})
      unless cf.value.match(regexp).nil?
        tag.expand
      end
    end
    
    desc %{
      The opposite of @if_matches@ tag.
      
      <pre><code><r:unless_matches matches="regexp" name="custom_field_name">...</r:unless_matches></code></pre>
    }
    
    tag 'unless_matches' do |tag|
      raise TagError.new("'matches' attribute required") unless matches = tag.attr['matches']
      raise TagError.new("'name' attribute required") unless name = tag.attr['name'] or tag.locals.custom_field
      regexp = Regexp.new tag.attr['matches']
      cf = tag.locals.custom_field || tag.locals.page.custom_fields.find(:first, :conditions => {:name => name})
      if cf.value.match(regexp).nil?
        tag.expand
      end
    end
  end
end