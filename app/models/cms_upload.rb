class CmsUpload < ActiveRecord::Base

Paperclip::Attachment.interpolations[:cms_upload_dir_label] = proc do |attachment, style|
  attachment.instance.cms_upload_dir_label
end
# -- AR Extensions --------------------------------------------------------
  has_attached_file :file,
                    :url => '/common/:cms_upload_dir_label/:basename.:extension',
                    :path => Rails.public_path + "/" + LucyCms.config.cms_upload_directory + "/:cms_upload_dir_label/:basename.:extension"
  
  # -- Relationships --------------------------------------------------------
  belongs_to :cms_upload_dir
  belongs_to :cms_user
  
  # -- Validations ----------------------------------------------------------
  validates :cms_upload_dir_id, :presence => true
  validates_attachment_presence :file
  
end
