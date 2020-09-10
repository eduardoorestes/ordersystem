class RemoveTimestamp < ActiveRecord::Migration
  def change
    remove_timestamps(:orders)
  end
end
