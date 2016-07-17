class CreateCashOutRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :cash_out_requests do |t|
      t.references :user, foreign_key: true
      t.decimal :amount, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
