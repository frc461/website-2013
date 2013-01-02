class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password, :password_confirmation, :password_hash, :password_salt, :username
  attr_accessor :password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def encrypt_password
    if password.present?
      self.password_salt = Bcrypt::Engine.generate_salt
      self.password_hash = Bcrypt::Engine.hash_secret(password, password_salt)
    end
  end

  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :posts
  has_one :principal, :as => :authenticatable
end
