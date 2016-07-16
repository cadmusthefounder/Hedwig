class AddCompletionTokenToTasks < ActiveRecord::Migration[5.0]
  class Task < ActiveRecord::Base
  end

  def up
    add_column :tasks, :completion_token, :string
    Task.all.each do |t|
      t.completion_token = SecureRandom.uuid[0..6]
      t.save
    end
  end

  def down
    remove_column :tasks, :completion_token, :string
  end
end
