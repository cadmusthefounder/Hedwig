class RenameMessagesTaskId < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :task_id, :interest_id
  end
end
