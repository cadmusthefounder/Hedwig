class Task < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"

  enum status: [ :brand_new, :accepted, :completed ]

  validates :from_address, presence: true
  validates :from_postal_code, length: { is: 6 }
  validates :to_address, presence: true
  validates :to_postal_code, length: { is: 6 }
  validates :price, presence: true

  def brand_new?
    return self.status == "brand_new"
  end

  def accepted?
    return self.status == "accepted"
  end

  def completed?
    return self.status == "completed"
  end

  def change_status(new_status)
    if Task.statuses.key?(new_status) || Task.statuses.value?(new_status)
      self.status = new_status
    end
  end

end
