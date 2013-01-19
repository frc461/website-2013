class Group < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  after_create :create_principal
  has_many :memberships
  has_many :users, :through => :memberships
  has_one :principal, :as => :authenticatable
  has_many :permissions, :through => :principal

  def create_principal
    p = Principal.create :authenticatable_type => "Group", :authenticatable_id => self.id
    has_many :todos
  end
end
