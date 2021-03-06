class User < ApplicationRecord
  has_many :tasks
  has_many :messages
  has_many :interests
  has_many :interested_tasks, through: :interests, source: :task
  has_many :sessions
  has_many :assigned_tasks, class_name: "Task", foreign_key: :assigned_user_id
  has_many :transactions

  has_many :reviews, dependent: :destroy
  has_many :owned_reviews, class_name: "Review", foreign_key: :owner_id

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :account_kit_id, presence: true, uniqueness: true

  def self.search(search)
    a = where('name LIKE ?', "%#{search}%")
    b = where('email LIKE ?', "%#{search}%")
    a.or(b)
  end

  def has_written_review_for(user)
    !(self.owned_review_ids & user.review_ids).empty?
  end

  def can_write_review_for(user)
    !self.tasks.where(status: "completed", assigned_user_id: user.id).empty?
  end

  def average_rating
    reviews.average(:rating) || 0
  end
end
