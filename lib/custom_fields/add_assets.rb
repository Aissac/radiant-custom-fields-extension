module CustomFields
  module AddAssets
    def self.included(base)
      base.class_eval do
        before_filter :add_assets, :only => [:edit]
        
        private        
          def add_assets
            include_stylesheet "admin/custom_fields"
            include_javascript "admin/custom_fields"
          end
      end
    end
  end
end