class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, :force => true do |t|
      t.references :user
      t.datetime :time
      t.string :event
      t.integer :info1
      t.integer :info2
      t.string :info3
    end
  end
end
