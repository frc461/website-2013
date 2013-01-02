class Group < ActiveRecord::Base
  attr_accessible :name

  has_many :memberships
  has_many :users, :through => :memberships
  has_one :principal, :as => :authenticatable
end
