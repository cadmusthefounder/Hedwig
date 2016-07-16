class CreateCreditPurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_purchases do |t|
      t.decimal :amount, null: false, default: 0
      t.references :user, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
