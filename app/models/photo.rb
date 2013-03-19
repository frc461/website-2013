class Photo < ActiveRecord::Base
  attr_accessible :album_id, :image
  has_attached_file :image,
                    :storage => :filesystem,
                    :styles => { :medium => "x512<", :thumb => "250x>" },
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

  belongs_to :album

  acts_as_taggable
end
