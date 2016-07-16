class AddAdminToUsers < ActiveRecord::Migration[5.0]
  class User < ActiveRecord::Base
  end

  def up
    add_column :users, :admin, :boolean, null: false, default: false

    User.all.each do |u|
      u.admin = false
      u.save
    end
  end

  def down
    remove_column :users, :admin, :boolean, null: false, default: false
  end
end
