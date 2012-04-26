class ChangeUserToUserId < ActiveRecord::Migration
    def change
        remove_column :events, :user
        add_column :events, :user_id, :integer
    end
end
