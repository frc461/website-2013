require "bcrypt"
class User < ActiveRecord::Base
	attr_accessible :admin, :email, :name, :group_ids, :password, :password_confirmation, :password_hash, :password_salt, :secret_code
	attr_accessor :password, :secret_code

	# Run the encrypt_password and set_admin functions before saving
	before_save :encrypt_password, :set_admin

	# TODO: Redo the validations to be more "modern"

	# The secret code should be given upon user creation and should match SECRET_CODE
	validates_each :secret_code do |record, attr, value|
		# SECRET_CODE should be defined in an initializer
		if record.secret_code != SECRET_CODE
			record.errors.add :secret_code, "is not correct"
		end
	end

	# If we do any changing to password, we need to have a confirmation.
	validates_confirmation_of :password

	# We need to have a password (at least for creation)
	validates_presence_of :password, on: :create

	# We need to have an email given
	validates_presence_of :email

	# And the email needs to be unique
	validates_uniqueness_of :email

	# We need to have a name given
	validates_presence_of :name

	def set_admin
		if self.admin == nil
			self.admin = false
		end

		return true
	end

	# Gets all of the permissions for the user (inheritance from groups is accounted for)
	def all_permissions
		# Start with an empty array
		shopping_cart = []

		# Then add our user's specific permissions
		shopping_cart.insert(self.permissions).flatten

		# And then add all of the permissions for their groups
		self.groups.each do |grp|
			shopping_cart.insert(grp.permissions).flatten
		end

		# :shipit:
		return shopping_cart
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

	# TODO: Redo the authentication system to use Rails 4's built-in passwords.

	def encrypt_password
		# If we have a password, then generate a salt and hash the password with the salt.
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	has_many :memberships
	has_many :groups, through: :memberships
	has_many :assignments
	has_many :todos, through: :assignments
	has_many :posts
	has_many :comments
end
