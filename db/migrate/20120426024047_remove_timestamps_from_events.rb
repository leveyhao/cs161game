class RemoveTimestampsFromEvents < ActiveRecord::Migration
  def up
    remove_timestamps(:events)
  end

  def down
    add_timestamps(:events)
  end
end
