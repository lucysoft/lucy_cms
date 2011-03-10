class CmsUploadDir < ActiveRecord::Base
  belongs_to :cms_site
  belongs_to :cms_user
  has_many :cms_uploads,  :dependent => :destroy

  validates :label,
    :presence   => true,
    :uniqueness => true,
    :format     => { :with => /^[^\<\>\/\*\\\? ]*$/ }

end
