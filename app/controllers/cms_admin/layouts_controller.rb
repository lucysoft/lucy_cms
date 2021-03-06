class CmsAdmin::LayoutsController < CmsAdmin::BaseController
  
  before_filter :check_for_admin
  before_filter :build_cms_layout,  :only => [:new, :create]
  before_filter :load_cms_layout,   :only => [:edit, :update, :destroy]
  
  def index
    return redirect_to :action => :new if @cms_site.cms_layouts.count == 0
    @cms_layouts = @cms_site.cms_layouts.roots
  end
  
  def new
    render
  end
  
  def edit
    render
  end
  
  def create
    @cms_layout.save!
    flash[:notice] = 'Layout created'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create layout'
    render :action => :new
  end
  
  def update
    @cms_layout.update_attributes!(params[:cms_layout])
    flash[:notice] = 'Layout updated'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update layout'
    render :action => :edit
  end
  
  def destroy
    @cms_layout.destroy
    flash[:notice] = 'Layout deleted'
    redirect_to :action => :index
  end
  
protected
  
  def check_for_admin
    if CmsUser.find_by_admin_and_disabled(true,false).nil?
      flash[:error] = 'You must create one Active Admin User to continue'
      redirect_to new_cms_admin_user_path
    end
  end

  def build_cms_layout
    @cms_layout = @cms_site.cms_layouts.new(params[:cms_layout])
    @cms_layout.parent ||= CmsLayout.find_by_id(params[:parent_id])
    @cms_layout.content ||= '{{ cms:page:content:text }}'
  end
  
  def load_cms_layout
    @cms_layout = @cms_site.cms_layouts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Layout not found'
    redirect_to :action => :index
  end
  
end
