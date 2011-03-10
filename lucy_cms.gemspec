# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{lucy_cms}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lucy"]
  s.date = %q{2011-03-09}
  s.description = %q{}
  s.email = %q{lucy@lucysoft.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/controllers/application_controller.rb",
    "app/controllers/cms_admin/base_controller.rb",
    "app/controllers/cms_admin/layouts_controller.rb",
    "app/controllers/cms_admin/pages_controller.rb",
    "app/controllers/cms_admin/sessions_controller.rb",
    "app/controllers/cms_admin/sites_controller.rb",
    "app/controllers/cms_admin/snippets_controller.rb",
    "app/controllers/cms_admin/upload_dirs_controller.rb",
    "app/controllers/cms_admin/users_controller.rb",
    "app/controllers/cms_content_controller.rb",
    "app/models/cms_block.rb",
    "app/models/cms_layout.rb",
    "app/models/cms_page.rb",
    "app/models/cms_site.rb",
    "app/models/cms_snippet.rb",
    "app/models/cms_upload.rb",
    "app/models/cms_upload_dir.rb",
    "app/models/cms_user.rb",
    "app/views/cms_admin/layouts/_form.html.erb",
    "app/views/cms_admin/layouts/_index_branch.html.erb",
    "app/views/cms_admin/layouts/edit.html.erb",
    "app/views/cms_admin/layouts/index.html.erb",
    "app/views/cms_admin/layouts/new.html.erb",
    "app/views/cms_admin/pages/_form.html.erb",
    "app/views/cms_admin/pages/_form_blocks.html.erb",
    "app/views/cms_admin/pages/_index_branch.html.erb",
    "app/views/cms_admin/pages/edit.html.erb",
    "app/views/cms_admin/pages/form_blocks.js.erb",
    "app/views/cms_admin/pages/index.html.erb",
    "app/views/cms_admin/pages/new.html.erb",
    "app/views/cms_admin/pages/toggle_branch.js.erb",
    "app/views/cms_admin/sessions/new.html.erb",
    "app/views/cms_admin/sites/_form.html.erb",
    "app/views/cms_admin/sites/edit.html.erb",
    "app/views/cms_admin/sites/new.html.erb",
    "app/views/cms_admin/sites/setup.html.erb",
    "app/views/cms_admin/snippets/_form.html.erb",
    "app/views/cms_admin/snippets/edit.html.erb",
    "app/views/cms_admin/snippets/index.html.erb",
    "app/views/cms_admin/snippets/new.html.erb",
    "app/views/cms_admin/upload_dirs/_file.html.erb",
    "app/views/cms_admin/upload_dirs/_form.html.erb",
    "app/views/cms_admin/upload_dirs/conflict.html.erb",
    "app/views/cms_admin/upload_dirs/index.html.erb",
    "app/views/cms_admin/upload_dirs/new.html.erb",
    "app/views/cms_admin/upload_dirs/show.html.erb",
    "app/views/cms_admin/upload_dirs/uploads_destroy.js.erb",
    "app/views/cms_admin/users/_form.html.erb",
    "app/views/cms_admin/users/_index_branch.html.erb",
    "app/views/cms_admin/users/change_password.html.erb",
    "app/views/cms_admin/users/edit.html.erb",
    "app/views/cms_admin/users/index.html.erb",
    "app/views/cms_admin/users/new.html.erb",
    "app/views/layouts/cms_admin.html.erb",
    "config.ru",
    "config/application.rb",
    "config/boot.rb",
    "config/database.yml",
    "config/environment.rb",
    "config/environments/development.rb",
    "config/environments/production.rb",
    "config/environments/test.rb",
    "config/initializers/lucy_cms.rb",
    "config/initializers/mime_types.rb",
    "config/locales/en.yml",
    "config/routes.rb",
    "db/cms_seeds/example.local/layouts/default.yml",
    "db/cms_seeds/example.local/layouts/nested.yml",
    "db/cms_seeds/example.local/pages/child.yml",
    "db/cms_seeds/example.local/pages/child/subchild.yml",
    "db/cms_seeds/example.local/pages/index.yml",
    "db/cms_seeds/example.local/snippets/example.yml",
    "db/migrate/01_create_cms.rb",
    "db/seeds.rb",
    "lib/LucyCMS/acts_as_tree.rb",
    "lib/LucyCMS/cms_tag.rb",
    "lib/LucyCMS/cms_tag/field_datetime.rb",
    "lib/LucyCMS/cms_tag/field_integer.rb",
    "lib/LucyCMS/cms_tag/field_string.rb",
    "lib/LucyCMS/cms_tag/field_text.rb",
    "lib/LucyCMS/cms_tag/helper.rb",
    "lib/LucyCMS/cms_tag/page_datetime.rb",
    "lib/LucyCMS/cms_tag/page_integer.rb",
    "lib/LucyCMS/cms_tag/page_rich_text.rb",
    "lib/LucyCMS/cms_tag/page_string.rb",
    "lib/LucyCMS/cms_tag/page_text.rb",
    "lib/LucyCMS/cms_tag/partial.rb",
    "lib/LucyCMS/cms_tag/snippet.rb",
    "lib/LucyCMS/configuration.rb",
    "lib/LucyCMS/controller_methods.rb",
    "lib/LucyCMS/engine.rb",
    "lib/LucyCMS/form_builder.rb",
    "lib/LucyCMS/rails_extensions.rb",
    "lib/LucyCMS/site_form_builder.rb",
    "lib/LucyCMS/view_hooks.rb",
    "lib/LucyCMS/view_methods.rb",
    "lib/generators/README",
    "lib/generators/cms_generator.rb",
    "lib/lucy_cms.rb",
    "lib/tasks/LucyCMS.rake",
    "lucy_cms.gemspec",
    "public/404.html",
    "public/422.html",
    "public/500.html",
    "public/favicon.ico",
    "public/images/LucyCMS/arrow_bottom.gif",
    "public/images/LucyCMS/arrow_right.gif",
    "public/images/LucyCMS/icon_folder.png",
    "public/images/LucyCMS/icon_layout.gif",
    "public/images/LucyCMS/icon_move.gif",
    "public/images/LucyCMS/icon_regular.gif",
    "public/images/LucyCMS/icon_snippet.gif",
    "public/images/LucyCMS/icon_upload.png",
    "public/images/LucyCMS/icon_user.jpg",
    "public/javascripts/LucyCMS/cms.js",
    "public/javascripts/LucyCMS/codemirror/codemirror.css",
    "public/javascripts/LucyCMS/codemirror/codemirror.js",
    "public/javascripts/LucyCMS/codemirror/codemirror_base.js",
    "public/javascripts/LucyCMS/codemirror/parse_css.js",
    "public/javascripts/LucyCMS/codemirror/parse_html_mixed.js",
    "public/javascripts/LucyCMS/codemirror/parse_js.js",
    "public/javascripts/LucyCMS/codemirror/parse_xml.js",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_flat_0_aaaaaa_40x100.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_flat_75_ffffff_40x100.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_glass_55_fbf9ee_1x400.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_glass_65_ffffff_1x400.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_glass_75_dadada_1x400.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_glass_75_e6e6e6_1x400.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_glass_95_fef1ec_1x400.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-bg_highlight-soft_75_cccccc_1x100.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-icons_222222_256x240.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-icons_2e83ff_256x240.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-icons_454545_256x240.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-icons_888888_256x240.png",
    "public/javascripts/LucyCMS/jquery-ui/images/ui-icons_cd0a0a_256x240.png",
    "public/javascripts/LucyCMS/jquery-ui/jquery-ui.css",
    "public/javascripts/LucyCMS/jquery-ui/jquery-ui.js",
    "public/javascripts/LucyCMS/jquery.js",
    "public/javascripts/LucyCMS/plupload/plupload.full.min.js",
    "public/javascripts/LucyCMS/plupload/plupload.html5.min.js",
    "public/javascripts/LucyCMS/plupload/plupload.min.js",
    "public/javascripts/LucyCMS/rails.js",
    "public/javascripts/LucyCMS/tiny_mce/jquery.tinymce.js",
    "public/javascripts/LucyCMS/tiny_mce/langs/en.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/about.htm",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/anchor.htm",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/charmap.htm",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/color_picker.htm",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/editor_template.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/image.htm",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/img/colorpicker.jpg",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/img/icons.gif",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/js/about.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/js/anchor.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/js/charmap.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/js/color_picker.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/js/image.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/js/link.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/js/source_editor.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/langs/en.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/langs/en_dlg.js",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/link.htm",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/content.css",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/dialog.css",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/img/buttons.png",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/img/items.gif",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/img/menu_arrow.gif",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/img/menu_check.gif",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/img/progress.gif",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/img/tabs.gif",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/skins/default/ui.css",
    "public/javascripts/LucyCMS/tiny_mce/themes/advanced/source_editor.htm",
    "public/javascripts/LucyCMS/tiny_mce/tiny_mce.js",
    "public/javascripts/LucyCMS/tiny_mce/tiny_mce_popup.js",
    "public/robots.txt",
    "public/stylesheets/LucyCMS/content.css",
    "public/stylesheets/LucyCMS/form.css",
    "public/stylesheets/LucyCMS/reset.css",
    "public/stylesheets/LucyCMS/site_form.css",
    "public/stylesheets/LucyCMS/structure.css",
    "public/stylesheets/LucyCMS/typography.css",
    "script/rails",
    "test/cms_seeds/test.host/layouts/broken.yml",
    "test/cms_seeds/test.host/layouts/default.yml",
    "test/cms_seeds/test.host/layouts/nested.yml",
    "test/cms_seeds/test.host/pages/broken.yml",
    "test/cms_seeds/test.host/pages/child.yml",
    "test/cms_seeds/test.host/pages/child/subchild.yml",
    "test/cms_seeds/test.host/pages/index.yml",
    "test/cms_seeds/test.host/snippets/broken.yml",
    "test/cms_seeds/test.host/snippets/default.yml",
    "test/fixtures/cms_blocks.yml",
    "test/fixtures/cms_layouts.yml",
    "test/fixtures/cms_pages.yml",
    "test/fixtures/cms_sites.yml",
    "test/fixtures/cms_snippets.yml",
    "test/fixtures/cms_upload_dirs.yml",
    "test/fixtures/cms_uploads.yml",
    "test/fixtures/cms_users.yml",
    "test/fixtures/files/invalid_file.gif",
    "test/fixtures/files/valid_image.jpg",
    "test/fixtures/views/_nav_hook.html.erb",
    "test/fixtures/views/_nav_hook_2.html.erb",
    "test/functional/cms_admin/layouts_controller_test.rb",
    "test/functional/cms_admin/pages_controller_test.rb",
    "test/functional/cms_admin/sites_controller_test.rb",
    "test/functional/cms_admin/snippets_controller_test.rb",
    "test/functional/cms_admin/uploads_controller_test.rb",
    "test/functional/cms_content_controller_test.rb",
    "test/integration/rake_tasks_test.rb",
    "test/integration/render_cms_seed_test.rb",
    "test/integration/render_cms_test.rb",
    "test/integration/sites_test.rb",
    "test/integration/view_hooks_test.rb",
    "test/test_helper.rb",
    "test/unit/cms_block_test.rb",
    "test/unit/cms_configuration_test.rb",
    "test/unit/cms_layout_test.rb",
    "test/unit/cms_page_test.rb",
    "test/unit/cms_site_test.rb",
    "test/unit/cms_snippet_test.rb",
    "test/unit/cms_tag_test.rb",
    "test/unit/cms_tags/field_datetime_test.rb",
    "test/unit/cms_tags/field_integer_test.rb",
    "test/unit/cms_tags/field_string_test.rb",
    "test/unit/cms_tags/field_text_test.rb",
    "test/unit/cms_tags/helper_test.rb",
    "test/unit/cms_tags/page_datetime_test.rb",
    "test/unit/cms_tags/page_integer_test.rb",
    "test/unit/cms_tags/page_rich_text.rb",
    "test/unit/cms_tags/page_string_test.rb",
    "test/unit/cms_tags/page_text_test.rb",
    "test/unit/cms_tags/partial_test.rb",
    "test/unit/cms_tags/snippet_test.rb",
    "test/unit/cms_upload_dir_test.rb",
    "test/unit/cms_upload_test.rb",
    "test/unit/cms_user_test.rb",
    "test/unit/view_methods_test.rb"
  ]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{LucyCMS is a Rails 3 CMS that lives inside your Rails App, but does not interfere with it}
  s.test_files = [
    "test/functional/cms_admin/layouts_controller_test.rb",
    "test/functional/cms_admin/pages_controller_test.rb",
    "test/functional/cms_admin/sites_controller_test.rb",
    "test/functional/cms_admin/snippets_controller_test.rb",
    "test/functional/cms_admin/uploads_controller_test.rb",
    "test/functional/cms_content_controller_test.rb",
    "test/integration/rake_tasks_test.rb",
    "test/integration/render_cms_seed_test.rb",
    "test/integration/render_cms_test.rb",
    "test/integration/sites_test.rb",
    "test/integration/view_hooks_test.rb",
    "test/test_helper.rb",
    "test/unit/cms_block_test.rb",
    "test/unit/cms_configuration_test.rb",
    "test/unit/cms_layout_test.rb",
    "test/unit/cms_page_test.rb",
    "test/unit/cms_site_test.rb",
    "test/unit/cms_snippet_test.rb",
    "test/unit/cms_tag_test.rb",
    "test/unit/cms_tags/field_datetime_test.rb",
    "test/unit/cms_tags/field_integer_test.rb",
    "test/unit/cms_tags/field_string_test.rb",
    "test/unit/cms_tags/field_text_test.rb",
    "test/unit/cms_tags/helper_test.rb",
    "test/unit/cms_tags/page_datetime_test.rb",
    "test/unit/cms_tags/page_integer_test.rb",
    "test/unit/cms_tags/page_rich_text.rb",
    "test/unit/cms_tags/page_string_test.rb",
    "test/unit/cms_tags/page_text_test.rb",
    "test/unit/cms_tags/partial_test.rb",
    "test/unit/cms_tags/snippet_test.rb",
    "test/unit/cms_upload_dir_test.rb",
    "test/unit/cms_upload_test.rb",
    "test/unit/cms_user_test.rb",
    "test/unit/view_methods_test.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.3"])
      s.add_runtime_dependency(%q<active_link_to>, [">= 0.0.6"])
      s.add_runtime_dependency(%q<paperclip>, [">= 2.3.8"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_runtime_dependency(%q<net-ldap>, [">= 0.1.1"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.3"])
      s.add_dependency(%q<active_link_to>, [">= 0.0.6"])
      s.add_dependency(%q<paperclip>, [">= 2.3.8"])
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<net-ldap>, [">= 0.1.1"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.3"])
    s.add_dependency(%q<active_link_to>, [">= 0.0.6"])
    s.add_dependency(%q<paperclip>, [">= 2.3.8"])
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<net-ldap>, [">= 0.1.1"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end

