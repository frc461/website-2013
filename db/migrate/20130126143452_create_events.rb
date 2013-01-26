class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.datetime :startDate
      t.datetime :endDate
      t.string :location
      t.boolean :public

      t.timestamps
    end
  end
end
