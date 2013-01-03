class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.integer :authenticatable_id
      t.string :authenticatable_type

      t.timestamps
    end
  end
end
