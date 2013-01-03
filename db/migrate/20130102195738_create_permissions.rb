class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :principal_id
      t.boolean :read
      t.boolean :write
      t.boolean :remove
      t.boolean :execute
      t.integer :securable_id
      t.string :securable_id
      t.integer :priority

      t.timestamps
    end
  end
end
