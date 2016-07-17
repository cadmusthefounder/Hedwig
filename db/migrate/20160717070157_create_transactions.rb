class CreateTransactions < ActiveRecord::Migration[5.0]
  class Transaction < ActiveRecord::Base
  end

  class CreditPurchase < ActiveRecord::Base
  end

  class CashOutRequest < ActiveRecord::Base
  end

  def up
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.decimal :amount, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :transaction_type, null: false, default: 0

      t.timestamps
    end

    CreditPurchase.all.each do |purchase|
      transaction = Transaction.new
      transaction.user_id          = purchase.user_id
      transaction.amount           = purchase.amount
      transaction.status           = purchase.status
      transaction.transaction_type = 0
      transaction.created_at       = purchase.created_at
      transaction.save!
    end

    CashOutRequest.all.each do |request|
      transaction = Transaction.new
      transaction.user_id          = request.user_id
      transaction.amount           = request.amount
      transaction.status           = request.status
      transaction.transaction_type = 1
      transaction.created_at       = request.created_at
      transaction.save!
    end

    drop_table :credit_purchases
    drop_table :cash_out_requests
  end

  def down
    create_table :credit_purchases do |t|
      t.decimal :amount, null: false, default: 0
      t.references :user, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    create_table :cash_out_requests do |t|
      t.references :user, foreign_key: true
      t.decimal :amount, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    Transaction.all.each do |transaction|
      if transaction.transaction_type == 0
        obj = CreditPurchase.new
      else
        obj = CashOutRequest.new
      end

      obj.user_id    = transaction.user_id
      obj.amount     = transaction.amount
      obj.status     = transaction.status
      obj.created_at = transaction.created_at
      obj.save!
    end

    drop_table :transactions
  end
end
