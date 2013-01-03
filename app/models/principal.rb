class Principal < ActiveRecord::Base
  attr_accessible :authenticatable_id, :authenticatable_type

  has_many :permissions
  belongs_to :securable, :polymorphic => true
  belongs_to :principal
end
