# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../../../../config/environment')
 
require 'cucumber/rails/world'
require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support
require 'webrat'
 
Webrat.configure do |config|
  config.mode = :rails
end
 
require 'firewatir'
require 'spec'

Before do
  ActiveRecord::Base.connection.tables.each do |table|
    begin
      table.classify.constantize.delete_all
    rescue StandardError => e
      # silent
    end
  end
  dataset_session.load_datasets_for(self.class)
end

After do
  system "killall firefox-bin"
end
# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
 
Cucumber::Rails::World.class_eval do
  include Dataset
  datasets_directory "#{RADIANT_ROOT}/spec/datasets"
  Dataset::Resolver.default = Dataset::DirectoryResolver.new("#{RADIANT_ROOT}/spec/datasets", File.dirname(__FILE__) + '/../../spec/datasets')
  self.datasets_database_dump_path = "#{Rails.root}/tmp/dataset"
  add_dataset :pages, :users, :custom_fields
end