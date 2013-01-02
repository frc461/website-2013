class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password_hash, :password_salt, :username

  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :posts
  has_one :principal, :as => :authenticatable
end
