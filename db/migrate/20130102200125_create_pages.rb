class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.integer :parent_id
      t.bool :navigable

      t.timestamps
    end
  end
end
