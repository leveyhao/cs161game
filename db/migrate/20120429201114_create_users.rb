class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users, :force => true do |t|
            t.string :device, :default => "mouse"

            t.timestamps
        end
    end
end
