class AddSortIndexToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sort_index, :integer
  end
end
