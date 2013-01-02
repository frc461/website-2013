class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.integer :securable_id
      t.string :securable_type

      t.timestamps
    end
  end
end
