class ChangeTimeToDecimalForEventsAgain < ActiveRecord::Migration
    def change
        remove_column :events, :time
        add_column :events, :time, :decimal, :precision => 15
    end
end
