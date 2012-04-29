class ChangeTimeToDecimalForEvents < ActiveRecord::Migration
    def change
        change_column :events, :time, :decimal, :precision => 15
    end
end
