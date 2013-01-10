class Photo < ActiveRecord::Base
  attr_accessible :album_id, :image

  has_attached_file :image

  belongs_to :album
  has_many :permissions, :as => :securable
end
