class CmsSite < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  has_many :cms_layouts,  :dependent => :destroy
  has_many :cms_pages,    :dependent => :destroy
  has_many :cms_snippets, :dependent => :destroy
  has_many :cms_uploads,  :dependent => :destroy
  has_many :cms_upload_dirs,  :dependent => :destroy
  
  # -- Validations ----------------------------------------------------------
  validates :label,
    :presence   => true,
    :uniqueness => true
  validates :hostname,
    :presence   => true,
    :uniqueness => true,
    :format     => { :with => /^[\w\.\-]+$/ }

  validates :authentication,
   :presence => true

  validates :ldap_hostname,
    :presence => true,
    :unless => :no_ldap

  validates :ldap_base_DN,
    :presence => true,
    :unless => :no_ldap

  validates :ldap_uid,
    :presence => true,
    :unless => :no_ldap

  def no_ldap
    self.authentication != 'LDAP'
  end 

end
