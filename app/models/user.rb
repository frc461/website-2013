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

	# Gets all of the permissions for the user (inheritance from groups is accounted for)
	def all_permissions
		shopping_cart = self.permissions.dup.flatten
		
		self.groups.each do |grp|
			shopping_cart.insert(grp.permissions).flatten
		end
		
		shopping_cart
	end

	# The authentification function
	def self.authenticate(email, password)
		# We find by email (hence the need for unique emails)
		user = User.where(email: email).first

		# If the user exists, check that their password_hash matches the hash created by hashing
		# the given password with the password_salt, and return the user if they authenticate
		# successfully (nil otherwise)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			return user
		else
			return nil
		end
	end
end
