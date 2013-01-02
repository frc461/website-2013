class Forum < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :comments
  has_many :permissions, :as => :securable
end
