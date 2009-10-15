namespace :radiant do
  namespace :extensions do
    namespace :custom_fields do
      
      desc "Runs the migration of the Custom Fields extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          CustomFieldsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          CustomFieldsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Custom Fields to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from CustomFieldsExtension"
        Dir[CustomFieldsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(CustomFieldsExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
