require "digest/sha1"
class User < ActiveRecord::Base
 
  has_many :comments

  attr_accessor :password_confirmation

  validates_presence_of :name
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :name
  validates_confirmation_of :password
  validates_format_of  :email,:with =>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,:message=>' email is not correct'
 

  validate :password_non_blank

  def password_non_blank
    errors.add_to_base("Missing password") if hashed_password.blank?
  end

  def self.encrypted_password(password,salt)
    string_to_hash =password+"wibble"+salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt=self.object_id.to_s+rand.to_s
  end

  def password
    @password
  end

  def password=(pwd)
    @password=pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password=User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(email,password)
    user =self.find_by_email(email)
    if user
      expected_password=self.encrypted_password(password, user.salt)
      if user.hashed_password!=expected_password
        user=nil
      end
    end
    user
  end

  def after_destroy
    raise "Can not delete last admin" if User.all(:conditions=>{:admin=>true})==[]
  end

  def admin?
    self.admin
  end
end
