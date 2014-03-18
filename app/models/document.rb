class Document < ActiveRecord::Base
	attr_accessible :filename, :name, :secret_code
	attr_accessor :secret_code

	validates_each :secret_code do |record, attr, value|
		if record.secret_code != DOCUMENT_SECRET_CODE #defined in secret.rb
			record.errors.add :secret_code, "is not correct"
		end
	end
end
