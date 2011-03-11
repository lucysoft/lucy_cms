class LucyCms::Configuration
  
  attr_accessor :version 
  
  # Default url to access admin area is http://yourhost/cms-admin/ 
  # You can change 'cms-admin' to 'admin', for example.
  attr_accessor :admin_route_prefix
  
  # /cms-admin redirects to /cms-admin/pages but you can change it
  # to something else
  attr_accessor :admin_route_redirect
  
  # Location of YAML files that can be used to render pages instead of pulling
  # data from the database. Not active if not specified.
  attr_accessor :seed_data_path

  attr_accessor :cms_upload_directory
  
  # Not allowing irb code to be run inside page content. True by default.
  attr_accessor :disable_irb
  
  # Caching for css/js. For admin layout and ones for cms content. Enabled by default.
  attr_accessor :enable_caching
  
  # Configuration defaults
  def initialize
    @version              = '0.0.6'
    @admin_route_prefix   = 'cms-admin'
    @admin_route_redirect = "/#{@admin_route_prefix}/pages"
    @seed_data_path       = nil
    @cms_upload_directory = 'common'
    @disable_irb          = true
    @enable_caching       = true
  end
  
end
