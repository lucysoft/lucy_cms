class CmsAdmin::SessionsController < CmsAdmin::BaseController
  
  skip_before_filter :cms_login_required

  def new
    @cms_user = CmsUser.new
  end

  def create
    @cms_current_user = CmsUser.authenticate(params[:login], params[:password], @cms_site.authentication, @cms_site.ldap_hostname, @cms_site.ldap_base_DN, @cms_site.ldap_uid)
    if @cms_current_user
      session[:cms_user_id] = @cms_current_user.id
      redirect_to cms_admin_pages_path
    else
      flash[:error] = 'Incorrect Login or Password'
      render :action => :new
    end
  end

  def destroy
    session[:cms_user_id] = @cms_current_user = nil
    redirect_to :action => :new
  end

end
