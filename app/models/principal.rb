class Principal < ActiveRecord::Base
  attr_accessible :authenticatable_id, :authenticatable_type

  has_many :permissions
  belongs_to :authenticatable, :polymorphic => true
end
