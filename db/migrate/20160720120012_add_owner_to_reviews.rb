class AddOwnerToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :owner, foreign_key: true
  end
end
