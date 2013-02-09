class AddGroupToForums < ActiveRecord::Migration
  def change
    add_column :forums, :group_id, :integer
  end
end
