require "bcrypt"

class User < ActiveRecord::Base
	attr_accessible :admin, :email, :name, :group_ids, :password, :password_confirmation, :password_hash, :password_salt, :secret_code
	attr_accessor :password, :secret_code

	has_many :memberships
	has_many :groups, :through => :memberships
	has_many :assignments
	has_many :todos, :through => :assignments
	has_many :posts
	has_many :comments
	
	before_save :encrypt_password, :set_admin
	
	validates :password, confirmation: true, presence: true, on: :create
	validates :email, :name, presence: true, uniqueness: true
	# Hacky way to validate that :secret_code equals SECRET_CODE.
	validates :secret_code, format: { with: /\A#{SECRET_CODE}\z/, message: "is not correct" }

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def set_admin
		self.admin = false if self.admin.nil?

		# Return true because this is in before_save,
		# and if it does not return true then saving
		# will die.  It would return false otherwise,
		# because self.admin is set to false above.
		true
	end

	def all_permissions
		shopping_cart = self.permissions.dup.flatten
		
		self.groups.each do |grp|
			shopping_cart.insert(grp.permissions).flatten
		end
		
		shopping_cart
	end

	def self.authenticate(email, password)
		user = User.where(email: email).first

		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
end
