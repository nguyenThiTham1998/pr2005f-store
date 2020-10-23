class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :sub_comments, dependent: :destroy
  acts_as_tree order: "created_at DESC"
  validates :content, presence: true
  scope :order_by_time,->{ order(created_at: :desc) }
  scope :count_comment, -> {where('created_at >=?', 24.hour.ago)}
end
