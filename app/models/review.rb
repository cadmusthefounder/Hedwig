class Review < ApplicationRecord
  belongs_to :user

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :comment, presence: true, length: { maximum: 140 }
end
