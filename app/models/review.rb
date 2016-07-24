class Review < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: "User"

  validates :rating, presence: true,  numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :comment, presence: true, length: { maximum: 140 }
end
