class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user
      t.integer :time
      t.string :event
      t.integer :info1
      t.integer :info2
      t.string :info3

      t.timestamps
    end
  end
end
