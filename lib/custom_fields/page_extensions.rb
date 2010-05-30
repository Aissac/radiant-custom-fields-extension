module CustomFields
  module PageExtensions    
    def self.included(base)
      base.class_eval do
        has_many :custom_fields
      end
    end  
  end
end