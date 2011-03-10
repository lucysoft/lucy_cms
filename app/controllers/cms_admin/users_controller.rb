class CmsAdmin::UsersController < CmsAdmin::BaseController

  before_filter :check_for_admin, :only => :index
  before_filter :check_admin, :except => :index
  
  def index
    @cms_users = CmsUser.find(:all, :order => 'last_name ASC')
  end

  def new
    @cms_user = CmsUser.new
  end

  def create
    @cms_user = CmsUser.new(params[:cms_user])
    if @cms_site.authentication == 'LDAP'
      username = @cms_user.login
      ldap = Net::LDAP.new(:host => @cms_site.ldap_hostname, :base => @cms_site.ldap_base_DN)
      filter = Net::LDAP::Filter.eq(@cms_site.ldap_uid, username)
      ldap.search(:filter => filter) do |entry|
        username = entry.dn
      end
      if username == @cms_user.login
        flash[:error] = "Username not in LDAP"
        render :action => 'new'
        return
      end
    end
    if CmsUser.find_by_admin_and_disabled(true,false).nil? 
      if @cms_user.admin == false || @cms_user.disabled == true
        flash[:error] = 'The first user you create must be an Active Admin'
        render :action => 'new'
      else
        if @cms_user.save
          flash[:notice] = 'User Created'
          redirect_to cms_admin_users_path
        else
          flash[:error] = 'User could not be created'
          render :action => 'new'
        end
      end
    else
      if @cms_user.save
        flash[:notice] = 'User Created'
        redirect_to cms_admin_users_path
      else
        flash[:error] = 'User could not be created'
        render :action => 'new'
      end
    end
  end
  
  def edit
    @cms_user = CmsUser.find_by_id(params[:id])
  end

  def update
    @cms_user = CmsUser.find(params[:id])
    @cms_user.attributes = params[:cms_user]
    if @cms_site.authentication == 'LDAP'
      username = @cms_user.login
      ldap = Net::LDAP.new(:host => @cms_site.ldap_hostname, :base => @cms_site.ldap_base_DN)
      filter = Net::LDAP::Filter.eq(@cms_site.ldap_uid, username)
      ldap.search(:filter => filter) do |entry|
        username = entry.dn
      end
      if username == @cms_user.login
        flash[:error] = "Username not in LDAP"
        render :action => 'edit'
        return
      end
    end
    if @cms_user.disabled == true && CmsUser.find(:all, :conditions => {:admin => true, :disabled => false}).count == 1 &&  CmsUser.find(:all, :conditions => {:admin => true, :disabled => false}).first.id == @cms_user.id
      flash[:error] = "You can not disable the only Admin"
      render :action => 'edit'
    else
      if @cms_user.admin == false && CmsUser.find(:all, :conditions => {:admin => true, :disabled => false}).count == 1 && CmsUser.find(:all, :conditions => {:admin => true, :disabled => false}).first.id == @cms_user.id
        flash[:error] = "You must have one Active Admin User"
        render :action => 'edit'
      else
        if @cms_user.save
           flash[:notice] = "User was updated"
           redirect_to cms_admin_users_path
        else
          flash[:error] = 'User could not be updated'
          render :action => 'edit'
        end
      end
    end
  end

  def change_password
    @cms_user = CmsUser.find_by_id(params[:id])
  end

  def update_password
    @cms_user = CmsUser.find_by_id(params[:id])
    @cms_user.attributes = params[:cms_user]
    if @cms_user.password.nil? || @cms_user.password.empty?
      flash[:error] = 'Password can not be blank'
      render :action => 'change_password'
      return
    end
    if @cms_user.save
      flash[:notice] = "Password was updated"
      redirect_to cms_admin_users_path
    else
      flash[:error] = 'User could not be updated'
      render :action => 'change_password'
    end
  end

  protected

  def check_for_admin
    if CmsUser.find_by_admin_and_disabled(true,false).nil?
      flash[:error] = 'You must create one Active Admin User to continue'
      redirect_to new_cms_admin_user_path
    end
  end

  def check_admin
    if CmsUser.count > 0 and !CmsUser.find_by_id(session[:cms_user_id]).admin?
      flash[:error] = 'You must be an Admin to Create or Edit Users'
      redirect_to :action => 'index'
    end
  end

end
