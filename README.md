LucyCMS
===================================

LucyCMS is a tiny and powerful Rails 3 CMS.  This CMS is a plugin for your application, not the other way around.  This allow's you to have one codebase for both your application and CMS.

It is based on [Comfortable Mexican Sofa](https://github.com/twg/comfortable-mexican-sofa) by Oleg Khabarov at [The Working Group Inc](http://www.twg.ca)

Installation
------------
Add gem definition to your Gemfile:
    
    gem 'lucy_cms'
    
Then from the Rails project's root run:
    
    bundle install
    rails g cms
    rake db:migrate
    
    
Usage
-----
After finishing installation you should be able to navigate to http://yoursite/cms-admin

First you must setup the site.  LucyCMS will ask you for a title for the site, the hostname, and if you want to authenticate via a local database or LDAP.  If you choose LDAP, some further settings are needed.

After you set up your site, you must create one Admin User.  After this user is created, LucyCMS will require you to login from here on out.  Relogin as the user you just created and you can create more users.

Before creating pages and populating them with content you need to create a layout. A layout is the template of your pages; it defines some reusable content (like header and footer, for example) and places where the content goes. A very simple layout can look like this:
    
    <html>
      <body>
        <h1>{{ cms:page:header:string }}</h1>
        {{ cms:page:content:text }}
      </body>
    </html>

Once you have a layout, you may start creating pages and populating content. It's that easy.

Many options can be found and changed in the cms initializer: /config/initializers/lucy_cms.rb

CMS Tags
--------
There are a number of cms tags that define where the content goes and how it's populated. **Page** and **Field** tags are used during layout creation. **Snippet**, **Helper** and **Partial** tags can be peppered pretty much anywhere. Tag is structured like so:
    
    {{ cms:page:content:text }}
        \    \     \      \ 
         \    \     \      ‾ tag format or extra attributes
          \    \     ‾‾‾‾‾‾‾ label/slug/path for the tag, 
           \    ‾‾‾‾‾‾‾‾‾‾‾‾ tag type (page, field, snippet, helper, partial)
            ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ cms tag identifier
           
Here's a number of tag variations:
    
    # Page tags are pieces of text content that will get rendered on the page. Format defines how form field
    # gets rendered in the page editing/creation section of the admin area.
    
    {{ cms:page:some_label:text }}
    {{ cms:page:some_label }}             # shorthand for above. 'text' is default format for pages
    {{ cms:page:some_label:string }}      # in admin area text field is displayed instead of textarea
    {{ cms:page:some_label:datetime }}    # similarly, datetime widget in the admin area
    {{ cms:page:some_label:integer }}     # a number field
    {{ cms:page:some_label:rich_text }}   # TinyMCE wysiwyg editor will be used to edit this content
    
    # Field tags are pieces of text content that are NOT rendered on the page. They can be accessed via
    # your application's layout / helpers / partials etc. Useful for populating this like <meta> tags.
    # Field formats are exactly the same as for Page tags.
    
    {{ cms:field:some_label:string }}
    {{ cms:field:some_label }}            # same as above. 'string' is default format for fields
    
    # Snippet tags are bits or reusable content that can be used anywhere. Imagine creating content like
    # a sharing widget, or business address that you want to randomly use across your site.
    
    {{ cms:snippet:some_label }}
    
    # Helper is a wrapper for your regular helpers. Normally you cannot have IRB in CMS content, so there are
    # tags that allow calling helpers and partials.
    
    {{ cms:helper:method_name }}          # same as <%= method_name() %>
    {{ cms:helper:method_name:x:y:z }}    # same as <%= method_name('x', 'y', 'z') %>
    
    # Partial tags are wrappers just like above helper ones.
    
    {{ cms:partial:path/to/partial }}     # same as <%= render :partial => 'path/to/partial' %>
    {{ cms:partial:path/to/partial:a:b }} # same as <%= render :partial => 'path/to/partial',
                                          #   :locals => { :param_1 => 'a', :param_1 => 'b' } %>
                                          
Uploads
-------
Uploads is where LucyCMS differs heavily from it's original code base at [Comfortable Mexican Sofa](https://github.com/twg/comfortable-mexican-sofa)

By default all uploads go into the public/common/ directory (although this can be changed in the /config/initializers/LucyCMS.rb file).  From the uploads tab, you can now create subfolders and upload your content.  This way you can add the common directory to your .gitignore file and your CMS content will not be affected by any canges in your code.

Integrating CMS with your app
-----------------------------
LucyCMS is a plugin, so it allows you to easily access content it manages. Here's some things you can do.

You can use CMS pages as regular views:
    
    def show
      @dinosaur = Dinosaur.find(params[:id])
      # CMS page probably should have either helper or partial tag to display @dinosaur details
      render :cms_page => '/dinosaur
    end
    
Actually, you don't need to explicitly render a CMS page like that. LucyCMS will try to rescue a TemplateNotFound by providing a matching CMS page.

You can access **Page** or **Field** tag content directly from your application (layouts/helpers/partials) via `cms_page_content` method. This is how you can pull things like meta tags into your application layout.
    
    # if @cms_page is available (meaning LucyCMS is doing the rendering)
    cms_page_content(:page_or_field_label)
    
    # anywhere else
    cms_page_content(:page_or_field_label, CmsPage.find_by_slug(...))
    
Similarly you can access **Snippet** content:
    
    cms_snippet_content(:snippet_slug)
    
Extending Admin Area
--------------------

If you wish, you can re-use LucyCMS's admin area for things you need to administer in your application. To do this, first you will need to make your admin controllers to inherit from CmsAdmin::BaseController. This way, your admin views will be using LucyCMS's admin layout and it's Authentication.
    
    class Admin::CategoriesController < CmsAdmin::BaseController
      # your code goes here
    end
    
Working with seeds
------------------
LucyCMS has seeds, functionality that helps manage content during development phase. It's very different from Rails seeds as LucyCMS's seeds are loaded with each page load. The database is completely bypassed when seeds are active. This way, you can source-control content before going live, disabling seeds and dumping everything into the database.

First, you will need to set a path where fixture files will be found (inside LucyCMS's initializer):
    
    if Rails.env.development? || Rails.env.test?
      LucyCMS.config.seed_data_path = File.expand_path('db/cms_seeds', Rails.root)
    end
    
If you ran `rails g cms`, you should find an example set of seeds in /db/cms\_seeds directory. Please note that seeds are nested in the folder that is the hostname of your site. Each file is an YAML representation of a database entry for that layout/page/snippet.

There's a rake task that makes moving seeds into database (and vice-versa) easy:
    
    # from seeds into database
    rake LucyCMS:import:all FROM=your-site.local TO=your-site.com SEED_PATH=/path/to/seeds
    
    # from database to seeds    
    rake LucyCMS:export:all FROM=your-site.com TO=your-site.local SEED_PATH=/path/to/seeds
    
Active Components
-----------------
LucyCMS utilizes the following:

* **[https://github.com/rails/rails](https://github.com/rails/rails)** - Ruby on Rails 3.*, of course
* **[https://github.com/thoughtbot/paperclip](https://github.com/thoughtbot/paperclip)** - Paperclip to handle file uploads
* **[https://github.com/twg/active_link_to](https://github.com/twg/active_link_to)** - Easy method to handle logic behind 'active' links

* * *

LucyCMS is released under the MIT licence
ComfortableMexicanSofa is released under the [MIT license](https://github.com/twg/comfortable-mexican-sofa/raw/master/LICENSE) 
