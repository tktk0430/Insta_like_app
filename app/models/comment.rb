class Comment < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, length: {maximum: 200}
end
