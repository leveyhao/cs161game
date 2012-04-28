class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.decimal :time, :precision => 15, :scale => 0
      t.string :event
      t.integer :info1
      t.integer :info2
      t.string :info3
    end
  end
end
