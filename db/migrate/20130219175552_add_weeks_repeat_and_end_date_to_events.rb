class AddWeeksRepeatAndEndDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :weeks_repeat, :integer
    add_column :events, :end_date, :date
  end
end
