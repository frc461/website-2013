class CleanUpFieldNamesInEvents < ActiveRecord::Migration
  def change
	  rename_column :events, :end_date, :end_repeat
	  rename_column :events, :startDate, :start_date
	  rename_column :events, :endDate, :end_date
  end
end
