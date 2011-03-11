class CmsAdmin::UploadDirsController < CmsAdmin::BaseController
  
  before_filter :check_and_set_base_dir, :except => :conflict

  def index
    return redirect_to :action => :new if @cms_site.cms_upload_dirs.count == 0
    @cms_upload_dirs = @cms_site.cms_upload_dirs.all(:order => 'label')
  end 

  def new
    @cms_upload_dir = @cms_site.cms_upload_dirs.new
    render
  end
  
  def create
    @cms_upload_dir = @cms_site.cms_upload_dirs.new(params[:cms_upload_dir])
    if File::exists?(File.join(@base_dir, @cms_upload_dir.label))
      flash[:error] = 'There is already a directory named ' + @cms_upload_dir.label
      render :action => :new
    else
      if @cms_upload_dir.save
        FileUtils.mkdir_p(File.join(@base_dir, @cms_upload_dir.label))
        flash[:notice] = 'Directory created'
        redirect_to :action => :index
      else
        flash[:error] = 'Not able to create directory'
        render :action => :new
      end
    end
  end
  
  def show
    @cms_upload_dir = @cms_site.cms_upload_dirs.find(params[:id])
    @cms_uploads = @cms_upload_dir.cms_uploads.find_all_by_cms_upload_dir_id( params[:id])
  end

  def uploads
    tempfile = params[:file].tempfile.path
    @cms_upload_dir = @cms_site.cms_upload_dirs.find(params[:id])
    @cms_upload_check = @cms_upload_dir.cms_uploads.find_by_cms_upload_dir_id_and_file_file_name( params[:id], params[:file].original_filename)
    unless @cms_upload_check.nil?
      @cms_upload_check.destroy
    end
    @cms_upload = @cms_upload_dir.cms_uploads.create!(:file => params[:file], :cms_upload_dir_label => @cms_upload_dir.label, :cms_user_id => @cms_current_user.id)
    if File::exists?(tempfile)
      File::delete(tempfile)
    end
    render :partial => 'file', :object => @cms_upload
  rescue ActiveRecord::RecordInvalid
    render :nothing => true, :status => :bad_request
  end
  
  def uploads_destroy
    @cms_upload = CmsUpload.find(params[:id])
    @cms_upload_dir = @cms_upload.cms_upload_dir
    @cms_upload.destroy
    redirect_to :action => :show, :id => @cms_upload_dir.id
  end

  def destroy
    @cms_upload_dir = @cms_site.cms_upload_dirs.find(params[:id])
    @cms_upload_dir.destroy
    if File::exists?(File.join(@base_dir, @cms_upload_dir.label)) && File::directory?(File.join(@base_dir, @cms_upload_dir.label))
      FileUtils.remove_dir(File.join(@base_dir, @cms_upload_dir.label))
    end
      flash[:notice] = 'Directory deleted'
      redirect_to :action => :index
  end

  def confilct
    render
  end

  protected
  
  def check_and_set_base_dir
    @base_dir = File.join(Rails.public_path,LucyCms.config.cms_upload_directory)
    if File::exists?(@base_dir) && !File::directory?(@base_dir)
      flash[:error] = 'File conflict'
      redirect_to :action => :conflict
    end
  end

end
