class Task < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_user, class_name: "User", optional: true
  has_many :messages
  has_many :interests
  has_many :interested_users, through: :interests, source: :user

  # brand_new   - The task is new.
  # assigned    - Requester has indicated the courier she wants but the courier
  #               has not indicated if he wants the job.
  # in_progress - The task is in progress. This indicates that the courier has
  #               accepted the offer.
  # completed   - The courier has completed the job.
  enum status: [ :brand_new, :assigned, :in_progress, :completed ]

  validates :from_address, presence: true
  validates :from_postal_code, length: { is: 6 }
  validates :to_address, presence: true
  validates :to_postal_code, length: { is: 6 }
  validates :price, presence: true

  def brand_new?
    status == "brand_new"
  end

  def assigned?
    status == "assigned"
  end

  def in_progress?
    status == "in_progress"
  end

  def completed?
    status == "completed"
  end

  def change_status(new_status)
    if Task.statuses.key?(new_status) || Task.statuses.value?(new_status)
      self.status = new_status
    end
  end

end
