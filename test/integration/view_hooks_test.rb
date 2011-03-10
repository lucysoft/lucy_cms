require File.expand_path('../test_helper', File.dirname(__FILE__))

class ViewHooksTest < ActionDispatch::IntegrationTest
  
  def test_hooks_rendering
    CmsAdmin::SitesController.append_view_path(File.expand_path('../fixtures/views', File.dirname(__FILE__)))
    LucyCMS::ViewHooks.add(:navigation, '/nav_hook')
    
    http_auth :get, cms_admin_sites_path
    assert_response :success
    assert_match /hook_content/, response.body
  end
  
  def test_hooks_rendering_with_multiples
    CmsAdmin::SitesController.append_view_path(File.expand_path('../fixtures/views', File.dirname(__FILE__)))
    LucyCMS::ViewHooks.add(:navigation, '/nav_hook')
    LucyCMS::ViewHooks.add(:navigation, '/nav_hook_2')
    
    http_auth :get, cms_admin_sites_path
    assert_response :success
    assert_match /hook_content/, response.body
    assert_match /<hook_content_2>/, response.body
  end
  
  def test_hooks_rendering_with_no_hook
    LucyCMS::ViewHooks.remove(:navigation)
    
    http_auth :get, cms_admin_sites_path
    assert_response :success
    assert_no_match /hook_content/, response.body
  end
  
end
