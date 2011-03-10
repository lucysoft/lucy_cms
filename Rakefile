# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rubygems'
require 'rake'

LucyCms::Application.load_tasks

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'lucy_cms'
    gem.summary     = 'LucyCMS is a Rails 3 CMS that lives inside your Rails App, but does not interfere with it'
    gem.description = ''
    gem.email       = 'lucy@lucysoft.com'
    gem.authors     = ['Lucy']

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
