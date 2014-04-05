class Document < ActiveRecord::Base
	attr_accessible :filename, :name, :secret_code
	attr_accessor :secret_code
	
	# Hacky way to validate that :secret_code equals SECRET_CODE.
	validates :secret_code, format: { with: /\A#{SECRET_CODE}\z/, message: "is not correct" }
end
