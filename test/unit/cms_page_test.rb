require File.expand_path('../test_helper', File.dirname(__FILE__))

class CmsPageTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    CmsPage.all.each do |page|
      assert page.valid?, page.errors.full_messages.to_s
      assert_equal page.read_attribute(:content), page.content(true)
    end
  end
  
  def test_validations
    page = CmsPage.new
    page.save
    assert page.invalid?
    assert_has_errors_on page, [:cms_layout, :slug, :label]
  end
  
  def test_validation_of_parent_presence
    page = cms_sites(:default).cms_pages.new(new_params)
    assert !page.parent
    assert page.valid?, page.errors.full_messages.to_s
    assert_equal cms_pages(:default), page.parent
  end
  
  def test_validation_of_parent_relationship
    page = cms_pages(:default)
    assert !page.parent
    page.parent = page
    assert page.invalid?
    assert_has_errors_on page, :parent_id
    page.parent = cms_pages(:child)
    assert page.invalid?
    assert_has_errors_on page, :parent_id
  end
  
  def test_validation_of_target_page
    page = cms_pages(:child)
    page.target_page = cms_pages(:default)
    page.save!
    assert_equal cms_pages(:default), page.target_page
    page.target_page = page
    assert page.invalid?
    assert_has_errors_on page, :target_page_id
  end
  
  def test_creation
    assert_difference ['CmsPage.count', 'CmsBlock.count'] do
      page = cms_sites(:default).cms_pages.create!(
        :label          => 'test',
        :slug           => 'test',
        :parent_id      => cms_pages(:default).id,
        :cms_layout_id  => cms_layouts(:default).id,
        :cms_blocks_attributes => [
          { :label    => 'test',
            :content  => 'test' }
        ]
      )
      assert page.is_published?
      assert_equal 1, page.position
    end
  end
  
  def test_initialization_of_full_path
    page = CmsPage.new
    assert_equal '/', page.full_path
    
    page = CmsPage.new(new_params)
    assert page.invalid?
    assert_has_errors_on page, :cms_site_id
    
    page = cms_sites(:default).cms_pages.new(new_params(:parent => cms_pages(:default)))
    assert page.valid?
    assert_equal '/test-page', page.full_path
    
    page = cms_sites(:default).cms_pages.new(new_params(:parent => cms_pages(:child)))
    assert page.valid?
    assert_equal '/child-page/test-page', page.full_path
    
    CmsPage.destroy_all
    page = cms_sites(:default).cms_pages.new(new_params)
    assert page.valid?
    assert_equal '/', page.full_path
  end
  
  def test_sync_child_pages
    page = cms_pages(:child)
    page_1 = cms_sites(:default).cms_pages.create!(new_params(:parent => page, :slug => 'test-page-1'))
    page_2 = cms_sites(:default).cms_pages.create!(new_params(:parent => page, :slug => 'test-page-2'))
    page_3 = cms_sites(:default).cms_pages.create!(new_params(:parent => page_2, :slug => 'test-page-3'))
    page_4 = cms_sites(:default).cms_pages.create!(new_params(:parent => page_1, :slug => 'test-page-4'))
    assert_equal '/child-page/test-page-1', page_1.full_path
    assert_equal '/child-page/test-page-2', page_2.full_path
    assert_equal '/child-page/test-page-2/test-page-3', page_3.full_path
    assert_equal '/child-page/test-page-1/test-page-4', page_4.full_path
    
    page.update_attributes!(:slug => 'updated-page')
    assert_equal '/updated-page', page.full_path
    page_1.reload; page_2.reload; page_3.reload; page_4.reload
    assert_equal '/updated-page/test-page-1', page_1.full_path
    assert_equal '/updated-page/test-page-2', page_2.full_path
    assert_equal '/updated-page/test-page-2/test-page-3', page_3.full_path
    assert_equal '/updated-page/test-page-1/test-page-4', page_4.full_path
    
    page_2.update_attributes!(:parent => page_1)
    page_1.reload; page_2.reload; page_3.reload; page_4.reload
    assert_equal '/updated-page/test-page-1', page_1.full_path
    assert_equal '/updated-page/test-page-1/test-page-2', page_2.full_path
    assert_equal '/updated-page/test-page-1/test-page-2/test-page-3', page_3.full_path
    assert_equal '/updated-page/test-page-1/test-page-4', page_4.full_path
  end
  
  def test_children_count_updating
    page_1 = cms_pages(:default)
    page_2 = cms_pages(:child)
    assert_equal 1, page_1.children_count
    assert_equal 0, page_2.children_count
    
    page_3 = cms_sites(:default).cms_pages.create!(new_params(:parent => page_2))
    page_1.reload; page_2.reload
    assert_equal 1, page_1.children_count
    assert_equal 1, page_2.children_count
    assert_equal 0, page_3.children_count
    
    page_3.update_attributes!(:parent => page_1)
    page_1.reload; page_2.reload
    assert_equal 2, page_1.children_count
    assert_equal 0, page_2.children_count
    
    page_3.destroy
    page_1.reload; page_2.reload
    assert_equal 1, page_1.children_count
    assert_equal 0, page_2.children_count
  end
  
  def test_cascading_destroy
    assert_difference 'CmsPage.count', -2 do
      cms_pages(:default).destroy
    end
  end
  
  def test_options_for_select
    assert_equal ['Default Page', '. . Child Page'], 
      CmsPage.options_for_select(cms_sites(:default)).collect{|t| t.first }
    assert_equal ['Default Page'], 
      CmsPage.options_for_select(cms_sites(:default), cms_pages(:child)).collect{|t| t.first }
    assert_equal [], 
      CmsPage.options_for_select(cms_sites(:default), cms_pages(:default))
    
    page = CmsPage.new(new_params(:parent => cms_pages(:default)))
    assert_equal ['Default Page', '. . Child Page'],
      CmsPage.options_for_select(cms_sites(:default), page).collect{|t| t.first }
  end
  
  def test_load_from_file
    assert !CmsPage.load_from_file(cms_sites(:default), '/')
    
    LucyCms.configuration.seed_data_path = File.expand_path('../cms_seeds', File.dirname(__FILE__))
    
    assert !CmsPage.load_from_file(cms_sites(:default), '/bogus')
    
    assert page = CmsPage.load_from_file(cms_sites(:default), '/')
    assert_equal 'Default Page', page.label
    assert_equal 1, page.cms_blocks.size
    assert page.cms_layout
    assert_equal '<html>Default Page Content</html>', page.content
    
    assert page = CmsPage.load_from_file(cms_sites(:default), '/child')
    assert_equal 1, page.cms_blocks.size
    assert page.cms_layout
    assert_equal '<html>Child Page Content</html>', page.content
    
    assert page = CmsPage.load_from_file(cms_sites(:default), '/child/subchild')
    assert_equal 1, page.cms_blocks.size
    assert page.cms_layout
    assert_equal 'Nested Layout', page.cms_layout.label
    assert_equal '<html><div>Sub Child Page Content Content for Default Snippet</div></html>', page.content
  end
  
  def test_load_from_file_broken
    LucyCms.configuration.seed_data_path = File.expand_path('../cms_seeds', File.dirname(__FILE__))
    error_message = "Failed to load from #{LucyCms.configuration.seed_data_path}/test.host/pages/broken.yml"
    assert_exception_raised RuntimeError, error_message do
      CmsPage.load_from_file(cms_sites(:default), '/broken')
    end
  end
  
  def test_load_for_full_path
    assert page = CmsPage.load_for_full_path!(cms_sites(:default), '/')
    assert !page.new_record?
    db_content = page.content
    
    LucyCms.configuration.seed_data_path = File.expand_path('../cms_seeds', File.dirname(__FILE__))
    assert page = CmsPage.load_for_full_path!(cms_sites(:default), '/')
    assert page.new_record?
    file_content = page.content
    assert_not_equal db_content, file_content
  end
  
  def test_load_for_full_path_exceptions
    assert_exception_raised ActiveRecord::RecordNotFound, 'CmsPage with path: /invalid_page cannot be found' do
      CmsPage.load_for_full_path!(cms_sites(:default), '/invalid_page')
    end
    assert !CmsPage.load_for_full_path(cms_sites(:default), '/invalid_page')
    
    LucyCms.configuration.seed_data_path = File.expand_path('../cms_seeds', File.dirname(__FILE__))
    assert_exception_raised ActiveRecord::RecordNotFound, 'CmsPage with path: /invalid_page cannot be found' do
      CmsPage.load_for_full_path!(cms_sites(:default), '/invalid_page')
    end
    assert !CmsPage.load_for_full_path(cms_sites(:default), '/invalid_page')
  end
  
  def test_cms_blocks_attributes_accessor
    page = cms_pages(:default)
    assert_equal page.cms_blocks.count, page.cms_blocks_attributes.size
    assert_equal 'default_field_text', page.cms_blocks_attributes.first[:label]
    assert_equal 'default_field_text_content', page.cms_blocks_attributes.first[:content]
    assert page.cms_blocks_attributes.first[:id]
  end
  
  def test_content_caching
    page = cms_pages(:default)
    assert_equal page.read_attribute(:content), page.content
    assert_equal page.read_attribute(:content), page.content(true)
    
    page.update_attribute(:content, 'changed')
    assert_equal page.read_attribute(:content), page.content
    assert_equal page.read_attribute(:content), page.content(true)
    assert_not_equal 'changed', page.read_attribute(:content)
  end
  
  def test_scope_published
    assert_equal 2, CmsPage.published.count
    cms_pages(:child).update_attribute(:is_published, false)
    assert_equal 1, CmsPage.published.count
  end
  
  def test_root?
    assert cms_pages(:default).root?
    assert !cms_pages(:child).root?
  end
  
  def test_url
    assert_equal 'http://test.host/', cms_pages(:default).url
    assert_equal 'http://test.host/child-page', cms_pages(:child).url
  end
  
protected
  
  def new_params(options = {})
    {
      :label      => 'Test Page',
      :slug       => 'test-page',
      :cms_layout => cms_layouts(:default)
    }.merge(options)
  end
end
