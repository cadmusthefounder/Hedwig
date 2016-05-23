class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :from_address
      t.string :from_postal_code
      t.string :to_address
      t.string :to_postal_code
      t.decimal :price

      t.timestamps
    end
  end
end
