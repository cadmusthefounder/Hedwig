class AddReadStatusesToInterests < ActiveRecord::Migration[5.0]
  class Interest < ApplicationRecord
  end

  def up
    add_column :interests, :read_by_owner, :boolean, null: false, default: false
    add_column :interests, :read_by_user, :boolean, null: false, default: true

    # Mark all existing interests as read, otherwise it's going to be annoying
    # as hell
    Interest.all.each do |interest|
      interest.update(read_by_owner: true, read_by_user: true)
    end
  end

  def down
    remove_column :interests, :read_by_owner
    remove_column :interests, :read_by_user
  end
end
