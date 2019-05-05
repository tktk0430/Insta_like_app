class Comment < ApplicationRecord
  include SessionsHelper
  default_scope->{order(created_at: :desc)}
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, length: {maximum: 200}

  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      comment_id:self.id,
      visited_id:self.micropost.contributer.id,
      micropost_id:self.micropost.id,
      action:"comment"
    )
    notification.save if notification.valid?
  end

  def delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      comment_id:self.id,
      visited_id:self.micropost.contributer.id,
      action:"comment"
    )
    notification.destroy if !notification.nil?
  end
end
