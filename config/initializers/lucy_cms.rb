LucyCms.configure do |config|
  
  # Default url to access admin area is http://yourhost/cms-admin/ 
  # You can change 'cms-admin' to 'admin', for example.
  #   config.admin_route_prefix = 'cms-admin'
  
  # Path: /cms-admin redirects to /cms-admin/pages but you can change it
  # You don't need to change it when changing admin_route_prefix
  #   config.admin_route_redirect = '/cms-admin/pages'
  
  # Location of YAML files that can be used to render pages instead of pulling
  # data from the database. Not active if not specified. Containing folder name
  # should be the hostname of the site. Example: my-app.local
  #   config.seed_data_path = File.expand_path('db/cms_seeds', Rails.root)

  # By default upload directories are placed in a directory called common
  # that is located public directory.  You can change the name of that 
  # subdirectory. Example: shared
  # config.cms_upload_directory = 'shared'
  
  # By default you cannot have irb code inside your layouts/pages/snippets.
  # Generally this is to prevent putting something like this:
  # <% User.delete_all %> but if you really want to allow it...
  #   config.disable_irb = true
  
  # Asset caching for CSS and JS for admin layout. This setting also controls
  # page caching for CMS Layout CSS and Javascript. Enabled by default. When deploying
  # to an environment with read-only filesystem (like Heroku) turn this setting off.
  #   config.enable_caching = true
  
end

# If you need to inject some html in cms admin views you can define what partial
# should be rendered into the following areas:
#   LucyCms::ViewHooks.add(:navigation, '/layouts/admin/navigation')
#   LucyCms::ViewHooks.add(:html_head, '/layouts/admin/html_head')
#   LucyCms::ViewHooks.add(:page_form, '/layouts/admin/page_form')
