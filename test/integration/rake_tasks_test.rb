require File.expand_path('../test_helper', File.dirname(__FILE__))

require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'

Rake.application.rake_require '../lib/tasks/LucyCMS'

class RakeTasksTest < ActionDispatch::IntegrationTest
  
  def test_layouts_import
    CmsLayout.destroy_all
    LucyCms.configuration.seed_data_path = File.expand_path('../cms_seeds', File.dirname(__FILE__))
    
    assert_difference 'CmsLayout.count', 2 do
      capture_rake_output{ 
        Rake.application['LucyCMS:import:check_for_requirements'].execute(
          :from => 'test.host', :to => 'test.host' )
        Rake.application['LucyCMS:import:layouts'].execute(
          :from => 'test.host', :to => 'test.host' )
      }
    end
  end
  
  def test_pages_import
    CmsPage.destroy_all
    LucyCms.configuration.seed_data_path = File.expand_path('../cms_seeds', File.dirname(__FILE__))
    
    assert_difference ['CmsPage.count', 'CmsBlock.count'], 3 do
      capture_rake_output{ 
        Rake.application['LucyCMS:import:check_for_requirements'].execute(
          :from => 'test.host', :to => 'test.host' )
        Rake.application['LucyCMS:import:pages'].execute(
          :from => 'test.host', :to => 'test.host' )
      }
    end
  end
  
  def test_snippets_import
    CmsSnippet.destroy_all
    LucyCms.configuration.seed_data_path = File.expand_path('../cms_seeds', File.dirname(__FILE__))
    
    assert_difference 'CmsSnippet.count', 1 do
      capture_rake_output{ 
        Rake.application['LucyCMS:import:check_for_requirements'].execute(
          :from => 'test.host', :to => 'test.host' )
        Rake.application['LucyCMS:import:snippets'].execute(
          :from => 'test.host', :to => 'test.host' )
      }
    end
  end
  
protected
  
  def capture_rake_output
    s = StringIO.new
    oldstdout = $stdout
    $stdout = s
    yield
    s.string
  ensure
    $stdout = oldstdout
  end
  
end
