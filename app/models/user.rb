require "bcrypt"
class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password, :password_confirmation, :password_hash, :password_salt, :username
  attr_accessor :password
  before_save :encrypt_password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :posts
  has_one :principal, :as => :authenticatable
end
