class Permission < ActiveRecord::Base
  attr_accessible :delete, :execute, :principal_id, :priority, :read, :securable_id, :securable_id, :write
end
