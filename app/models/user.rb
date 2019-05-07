class User < ApplicationRecord
  include ImageUploader[:image]
  include SessionsHelper
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :active_relationship, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationship, source: :followed
  has_many :passive_relationship, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationship, source: :follower
  has_many :active_like, class_name: "Like", dependent: :destroy
  has_many :like_posts, through: :active_like, source: :micropost
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 200},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}, allow_blank:true
  validates :email, presence: true
  validates :name,presence: true, length: {maximum: 20}
  validates :account, presence: true, uniqueness: true, length: {maximum: 20}
  validates :introduction, length: {maximum: 240}
  validates :password,length:{minimum: 6}, allow_nil: true
  validates :web, length: {maximum: 200}

  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable,  :omniauthable

  attr_accessor :current_password

  

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def self.search(query)
    ret=oreder(created_at: :desc)
    if query.exists?
      ret=ret.where("name LIKE ? or account LIKE ? or introduction LIKE ?", "#{query}","#{query}","#{query}")
    end
    return ret
  end

  def follow(user)
    self.active_relationship.create(followed_id: user.id)
  end

  def like(micropost)
    self.active_like.create(micropost_id: micropost.id)
  end

  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      visited_id:self.id,
      action:"follow"
    )
    notification.save if notification.valid?
  end

  def delete_notification_by(current_user)
    notification=current_user.active_notifications.find_by(
      visited_id:self.id,
      action:"follow"
    )
    notification.destroy if !notification.nil?
  end
end
