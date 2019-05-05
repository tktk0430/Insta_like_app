class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :user_id,  uniqueness: { scope: [:micropost_id]}
  validates :micropost_id, presence: true
end
