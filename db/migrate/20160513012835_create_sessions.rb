class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true
      t.string :remember_token

      t.timestamps
    end
    add_index :sessions, :remember_token, unique: true
  end
end
