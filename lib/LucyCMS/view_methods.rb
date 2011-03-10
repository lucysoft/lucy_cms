module LucyCms::ViewMethods
  # Wrapper around CmsFormBuilder
  def cms_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(record_or_name_or_array, *(args << options.merge(:builder => LucyCms::FormBuilder)), &proc)
  end

  def cms_site_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(record_or_name_or_array, *(args << options.merge(:builder => LucyCms::SiteFormBuilder)), &proc)
  end
  
  # Wrapper for <span>
  def span_tag(*args)
    content_tag(:span, *args)
  end
  
  # Rails 3.0 doesn't have this helper defined
  def datetime_field_tag(name, value = nil, options = {})
    text_field_tag(name, value, options.stringify_keys.update('type' => 'datetime'))
  end
  
  # Injects some content somewhere inside cms admin area
  def cms_hook(name, options = {})
    LucyCms::ViewHooks.render(name, self, options)
  end
  
  # Content of a snippet. Example:
  #   cms_snippet_content(:my_snippet)
  def cms_snippet_content(snippet_slug)
    return '' unless snippet = CmsSnippet.find_by_slug(snippet_slug)
    snippet.content.to_s.html_safe
  end
  
  # Content of a page block. This is how you get content from page:field
  # Example:
  #   cms_page_content(:left_column, CmsPage.first)
  #   cms_page_content(:left_column) # if @cms_page is present
  def cms_page_content(block_label, page = nil)
    return '' unless page ||= @cms_page
    return '' unless block = page.cms_blocks.find_by_label(block_label)
    block.content.to_s.html_safe
  end
end

ActionView::Base.send :include, LucyCms::ViewMethods

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :cms => [
  'LucyCMS/jquery',
  'LucyCMS/jquery-ui/jquery-ui',
  'LucyCMS/rails',
  'LucyCMS/tiny_mce/tiny_mce',
  'LucyCMS/tiny_mce/jquery.tinymce',
  'LucyCMS/plupload/plupload.min',
  'LucyCMS/plupload/plupload.html5.min',
  'LucyCMS/codemirror/codemirror.js',
  'LucyCMS/cms'
]
ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :cms => [
  'LucyCMS/reset',
  'LucyCMS/structure',
  'LucyCMS/typography',
  'LucyCMS/form',
  'LucyCMS/content',
  '/javascripts/LucyCMS/jquery-ui/jquery-ui'
]
