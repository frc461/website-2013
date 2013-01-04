require "bcrypt"
class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :group_ids, :password, :password_confirmation, :password_hash, :password_salt
  attr_accessor :password
  before_save :encrypt_password
  after_create :create_principal
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email

  def all_permissions
    shopping_cart = []
    shopping_cart.insert(self.permissions).flatten
    self.groups.each do |grp|
      shopping_cart.add(grp.permissions).flatten
    end
    shopping_cart
  end

  def self.authenticate(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def create_principal
    p = Principal.create :authenticatable_type => "User", :authenticatable_id => self.id
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
  has_many :permissions, :through => :principal
end
