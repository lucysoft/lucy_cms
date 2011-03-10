class CmsGenerator < Rails::Generators::Base
  
  include Rails::Generators::Migration
  include Thor::Actions
  
  source_root File.expand_path('../../..', __FILE__)
  
  def generate_migration
    destination   = File.expand_path('db/migrate/01_create_cms.rb', self.destination_root)
    migration_dir = File.dirname(destination)
    destination   = self.class.migration_exists?(migration_dir, 'create_cms')
    
    if destination
      puts "\e[0m\e[31mFound existing cms_create.rb migration. Remove it if you want to regenerate.\e[0m"
    else
      migration_template 'db/migrate/01_create_cms.rb', 'db/migrate/create_cms.rb'
    end
  end
  
  def generate_initialization
    copy_file 'config/initializers/lucy_cms.rb', 'config/initializers/lucy_cms.rb'
  end
  
  def generate_public_assets
    directory 'public/stylesheets/LucyCMS', 'public/stylesheets/LucyCMS'
    directory 'public/javascripts/LucyCMS', 'public/javascripts/LucyCMS'
    directory 'public/images/LucyCMS', 'public/images/LucyCMS'
  end
  
  def generate_cms_seeds
    directory 'db/cms_seeds', 'db/cms_seeds'
  end
  
  def show_readme
    readme 'lib/generators/README'
  end
  
  def self.next_migration_number(dirname)
    orm = Rails.configuration.generators.options[:rails][:orm]
    require "rails/generators/#{orm}"
    "#{orm.to_s.camelize}::Generators::Base".constantize.next_migration_number(dirname)
  end
  
end
