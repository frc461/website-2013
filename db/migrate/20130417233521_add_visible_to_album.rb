class AddVisibleToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :visible, :boolean
  end
end
