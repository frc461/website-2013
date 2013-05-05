class Photo < ActiveRecord::Base
	attr_accessible :album_id, :image
	validate :unique_filename_thingy
	has_attached_file :image,
	:storage => :filesystem,
	:styles => { :medium => "x512", :thumb => "250x>" },
	:path => "app/assets/images/images/:style-:filename",
	:url => "/assets/images/:style-:filename"

	include Rails.application.routes.url_helpers

	def to_jq_upload
		{
			"name" => read_attribute(:image_file_name),
			"size" => read_attribute(:image_file_size),
			"url" => image.url(:original),
			"delete_url" => photo_path(self),
			"delete_type" => "DELETE"
		}
	end

	def unique_filename_thingy
		errors.add(:base, "Already added this photo") unless Photo.where(:image_file_name => self.image_file_name).empty?
	end

	belongs_to :album

	acts_as_taggable
end
