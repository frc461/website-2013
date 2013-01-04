class Permission < ActiveRecord::Base
  attr_accessible :remove, :execute, :principal_id, :priority, :read, :securable_id, :securable_type, :write, :securable_string
  attr_accessor :securable_string
  before_save :securify

  belongs_to :securable, :polymorphic => true
  belongs_to :principal

  def securify
    if securable_string.include? "/" 
      type = securable_string.split("/")[0]
      id = securable_string.split("/")[1]
    else 
      type = securable_string
    end

    if ["Page", "Post", "Forum", "Photo", "Album"].include? type
      securable_type = type
      if securable_string.include?("/") && securable_type.constantize.where(:id => id)
        securable_id = id.to_i
      else
        self.errors.add(:base, "You fail")
      end
    else
      self.errors.add(:base, "You fail harder")
    end
  end
end
