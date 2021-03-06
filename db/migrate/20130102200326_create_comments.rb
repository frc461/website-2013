class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.string :title
      t.integer :parent_id
      t.boolean :sticky
      t.boolean :important

      t.timestamps
    end
  end
end
