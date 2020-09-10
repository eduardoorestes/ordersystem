class UpdateStateToEnum < ActiveRecord::Migration
  def change
    remove_reference(:orders, :state, index: true)
    remove_columns(:orders, :state)
  end
end
