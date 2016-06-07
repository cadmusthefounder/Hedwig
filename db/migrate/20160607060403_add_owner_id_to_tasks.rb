class AddOwnerIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :owner_id, :integer
  end
end
