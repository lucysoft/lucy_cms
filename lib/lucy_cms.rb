# Loading engine only if this is not a standalone installation
unless defined? LucyCms::Application
  require File.expand_path('LucyCMS/engine', File.dirname(__FILE__))
end

[ 'LucyCMS/configuration',
  'LucyCMS/rails_extensions',
  'LucyCMS/controller_methods',
  'LucyCMS/view_hooks',
  'LucyCMS/view_methods',
  'LucyCMS/form_builder',
  'LucyCMS/site_form_builder',
  'LucyCMS/acts_as_tree',
  '../app/models/cms_block',
  '../app/models/cms_snippet',
  'LucyCMS/cms_tag' 
].each do |path|
  require File.expand_path(path, File.dirname(__FILE__))
end

Dir.glob(File.expand_path('LucyCMS/cms_tag/*.rb', File.dirname(__FILE__))).each do |tag_path| 
  require tag_path
end

module LucyCms
  
  class << self
    
    # Modify CMS configuration
    # Example:
    #   LucyCMS.configure do |config|
    #     config.config.cms_upload_directory = 'shared'
    #   end
    def configure
      yield configuration
    end
    
    # Accessor for LucyCMS::Configuration
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration
    
  end
  
end
