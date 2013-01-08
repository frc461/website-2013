class Permission < ActiveRecord::Base
  attr_accessible :remove, :execute, :principal_id, :priority, :read, :securable_id, :securable_type, :write, :securable_string
  attr_accessor :securable_string
  before_save :securify

  belongs_to :securable, :polymorphic => true
  belongs_to :principal

  def securify
    puts "about to start if including /"
    if securable_string.include? "/"
      puts "includes, splitting on /"
      type = securable_string.split("/")[0]
      id = securable_string.split("/")[1]
    else
      puts "doesn't include"
      type = securable_string
    end
    puts "next part"

    if ["Page", "Post", "Forum", "Photo", "Album"].include? type
      puts "thing includes other things"
      securable_type = type
      puts securable_type
      if securable_string.include?("/") && securable_type.constantize.where(:id => id)
        puts "includes /, setting id"
        securable_id = id.to_i
        puts securable_id
      else
        self.errors.add(:base, "You fail")
      end
    else
      self.errors.add(:base, "You fail harder")
    end
  end
end
