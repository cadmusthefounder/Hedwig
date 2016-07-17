class AddDefaultValueForTaskPrice < ActiveRecord::Migration[5.0]
  def up
    change_column_default :tasks, :price, 0
  end

  def down
    change_column_default :tasks, :price, nil
  end
end
