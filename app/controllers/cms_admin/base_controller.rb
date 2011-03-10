class CmsAdmin::BaseController < ActionController::Base
  
  protect_from_forgery
  
    before_filter :fetch_cms_logged_in_user,
                  :load_admin_cms_site
  
  unless CmsSite.count == 0 || CmsUser.find(:all, :conditions => {:admin => true, :disabled => false}).count == 0
    before_filter :cms_login_required
  end
  layout 'cms_admin'
    
protected
  
  def load_admin_cms_site
   if CmsSite.count == 0
      flash[:error] = 'To start you must setup your site'
      redirect_to new_cms_admin_site_path
    else
      @cms_site = CmsSite.first
      if @cms_site.version <  LucyCms.config.version
        @cms_site.version = LucyCms.config.version
        @cms_site.save
      end
    end
  end
  
  def fetch_cms_logged_in_user
    return unless session[:cms_user_id]
     @cms_current_user = CmsUser.find_by_id(session[:cms_user_id])
  end
  
  def cms_logged_in?
    ! @cms_current_user.nil?
  end
  
  helper_method :cms_logged_in?
  
  def cms_login_required
    return true if cms_logged_in?
    redirect_to new_cms_admin_session_path and return false
  end 
end
