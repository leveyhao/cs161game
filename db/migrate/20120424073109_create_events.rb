class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user
      t.decimal :time, :precision => 15
      t.string :event
      t.integer :info1
      t.integer :info2
      t.string :info3

      t.timestamps
    end
  end
end
