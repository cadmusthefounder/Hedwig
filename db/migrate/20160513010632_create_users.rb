class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :account_kit_id

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :account_kit_id, unique: true
  end
end
