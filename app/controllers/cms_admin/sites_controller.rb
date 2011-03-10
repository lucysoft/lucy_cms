class CmsAdmin::SitesController < CmsAdmin::BaseController
  
  skip_before_filter :load_admin_cms_site, :only => [:new, :create]
  before_filter :check_admin, :except => [:new, :create, :setup]
  
  def new
    if CmsSite.count > 0
      flash[:error] = 'You can only have one site'
      redirect_to :action => :edit
    else
      @cms_site = CmsSite.new
      render
    end
  end
  
  def edit
    render
  end
  
  def create
    @cms_site = CmsSite.new(params[:cms_site])
    if @cms_site.authentication != 'LDAP'
      @cms_site.ldap_hostname = ''
      @cms_site.ldap_base_DN = ''
      @cms_site.ldap_uid = ''
    end
    if @cms_site.save
      redirect_to :controller => 'cms_admin/pages', :action => :new
    else
      flash[:error] = 'Not able to save setup'
      render :action => :new
    end
  end
  
  def update
    @cms_site.update_attributes(params[:cms_site])
    if @cms_site.authentication != 'LDAP'
      @cms_site.ldap_hostname = ''
      @cms_site.ldap_base_DN = ''
    end
    if @cms_site.save
      flash[:notice] = 'Site updated'
      redirect_to :action => :edit, :id => @cms_site
    else
      flash.now[:error] = 'Failed to update site'
      render :action => :edit
    end
  end
  
  def destroy
    @cms_site.destroy
    flash[:notice] = 'Site deleted'
    redirect_to :action => :index
  end
  
  def blank
    render
  end

  protected
  
  def check_admin
    unless CmsUser.count == 0
      if ! CmsUser.find_by_id(session[:cms_user_id]).admin?
        flash[:error] = 'You must be an Admin to change the Setup'
        redirect_to :action => 'setup'
      end 
    end
  end

end
