class Photo < ActiveRecord::Base
	include Rails.application.routes.url_helpers
	
	attr_accessible :album_id, :image

	belongs_to :album
	
	has_attached_file(:image,
	                  :storage => :filesystem,
	                  :styles => { :medium => "x512", :thumb => "250x>" },
	                  :path => "app/assets/images/images/:style-:filename",
	                  :url => "/assets/images/:style-:filename")
	
	validates :image_file_name, uniqueness: true

	def to_jq_upload
		{
			"name" => read_attribute(:image_file_name),
			"size" => read_attribute(:image_file_size),
			"url" => image.url(:original),
			"delete_url" => photo_path(self),
			"delete_type" => "DELETE"
		}
	end

	acts_as_taggable
end
