class Relationship < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  belongs_to :follower, class_name: "User" #foregin_keyは'follower'_idなので省略可
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :follower_id,  uniqueness: { scope: [:followed_id]}
  validate :follower_followed_cannot_same

  private
    def follower_followed_cannot_same
      errors.add(:user, 'は自身をフォローできません') if follower_id==followed_id
    end
end
