class RemoveInterestedTasksUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :interested_tasks_users, :task_id
    remove_index :interested_tasks_users, :user_id

    drop_table :interested_tasks_users, id: false do |t|
      t.integer :task_id
      t.integer :user_id
    end
  end
end
