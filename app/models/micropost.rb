class Micropost < ApplicationRecord
  include ImageUploader[:image]
  include SessionsHelper
  default_scope->{order(created_at: :desc)}

  belongs_to :contributer, class_name:'User', foreign_key: 'user_id'
  has_many :passive_like, class_name: "Like"
  has_many :like_users, through: :passive_like, source: :user
  has_many :comments
  has_many :notifications,dependent: :destroy
  
  validates :content, length:{maximum: 240}
  validates :image_data, presence: { message: "が選択されていません" }

  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      micropost_id:self.id,
      visited_id:self.contributer.id,
      action:"like"
    )
    notification.save if notification.valid?
  end

  def delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      micropost_id:self.id,
      visited_id:self.contributer.id,
      action:"like"
    )
    notification.destroy if !notification.nil?
  end
end
