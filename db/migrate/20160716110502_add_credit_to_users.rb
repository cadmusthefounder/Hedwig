class AddCreditToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :credit, :decimal, default: 0, null: false
  end
end
