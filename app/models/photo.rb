class Photo < ActiveRecord::Base
  attr_accessible :album_id

  belongs_to :album
  has_many :permissions, :as => :securable
end
