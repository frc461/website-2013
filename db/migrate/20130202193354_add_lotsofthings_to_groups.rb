class AddLotsofthingsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :page_access, :boolean
    add_column :groups, :post_access, :boolean
    add_column :groups, :photo_access, :boolean
    add_column :groups, :event_access, :boolean
    add_column :groups, :user_access, :boolean
    add_column :groups, :forum_access, :boolean
    add_column :groups, :group_access, :boolean
  end
end
