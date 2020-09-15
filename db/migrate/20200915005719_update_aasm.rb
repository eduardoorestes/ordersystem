class UpdateAasm < ActiveRecord::Migration
  def change
    remove_column(:orders, :state)
    add_column :orders, :aasm_state, :string
  end
end
