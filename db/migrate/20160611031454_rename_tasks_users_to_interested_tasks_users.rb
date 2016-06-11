class RenameTasksUsersToInterestedTasksUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :tasks_users, :interested_tasks_users
  end
end
