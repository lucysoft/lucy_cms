class CmsUser < ActiveRecord::Base

  validates :login,
    :presence   => true,
    :uniqueness => true

  validates :first_name,
    :presence   => true

  validates :last_name,
    :presence   => true

  @cms_site = CmsSite.first
  
  unless @cms_site.nil?
  if @cms_site.authentication != 'LDAP'
    attr_accessor :password_confirmation
    validates_confirmation_of :password

    validates :password,
      :presence => true,
      :on       =>  :create

    # 'password' is a virtual attribute
    def password
      @password
    end

    def password=(pwd)
      @password = pwd
      return if pwd.blank?
      create_new_salt
      self.hashed_password = CmsUser.encrypted_password(self.password, self.salt)
    end
  end
  end
 
  def full_name
    [first_name, last_name].join(' ')
  end

  def self.authenticate(login, password)

    if @cms_site.authentication == 'LDAP'
      username = login

      if (password.empty?) then
        return nil
      end

      ldap = Net::LDAP.new(:host => @cms_site.ldap_hostname, :base => @cms_site.ldap_base_DN)
      filter = Net::LDAP::Filter.eq(@cms_site.ldap_uid, login)
      ldap.search(:filter => filter) {|entry| login = entry.dn}
      ldap.auth(login, password)

      if ldap.bind
        user = CmsUser.find_by_login_and_disabled(username, false) # need to check if user is in the database and not disabled
        if (user)
          return user
        else
          #user is in LDAP but not in local database
          return nil
        end
      else
        #authentication failed
        return nil
      end
    else
      user= self.find_by_login(login)
      if user
        expected_password = encrypted_password(password, user.salt)
        if user.hashed_password != expected_password
          user = nil
        end
      end
      user
    end

rescue Net::LDAP::LdapError
  end
 
  private

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password,salt)
    string_to_hash = password + "LucyCMS" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

end
