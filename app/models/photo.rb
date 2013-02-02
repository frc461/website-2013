class Photo < ActiveRecord::Base
  attr_accessible :album_id, :image

  has_attached_file :image,
    :storage => :filesystem,
    :path => "app/assets/images/images/:filename",
    :url => "/assets/images/:filename"

  belongs_to :album

  acts_as_taggable
end
