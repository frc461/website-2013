class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password_hash, :password_salt, :username
end
