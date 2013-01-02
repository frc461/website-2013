class Album < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :photos
  has_many :permissions, :as => :securable
end
