class Book < ApplicationRecord
	is_impressionable counter_cache: true
    belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
  scope :created_thisweek, -> { where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  scope :created_lastweek, -> { where(created_at: 1.week.ago.all_day) } 

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
