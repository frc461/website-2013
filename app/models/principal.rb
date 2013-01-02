class Principal < ActiveRecord::Base
  attr_accessible :securable_id, :securable_type

  belongs_to :securable, :polymorphic => true
  belongs_to :principal
end
