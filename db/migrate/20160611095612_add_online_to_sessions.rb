class AddOnlineToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :online, :boolean, default: true
  end
end
