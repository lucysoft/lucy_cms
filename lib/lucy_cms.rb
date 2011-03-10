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
    #   ComfortableMexicanSofa.configure do |config|
    #     config.cms_title = 'Comfortable Mexican Sofa'
    #   end
    def configure
      yield configuration
    end
    
    # Accessor for ComfortableMexicanSofa::Configuration
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration
    
  end
  
end
