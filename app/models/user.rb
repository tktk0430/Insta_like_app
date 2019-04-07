class User < ApplicationRecord
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :active_relationship, class_name: "Relationship", foreign_key: "follower_id"
  has_many :following, through: :active_relationship, source: :followed
  has_many :passive_relationship, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followers, through: :passive_relationship, source: :follower
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 200},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}, allow_blank:true
  validates :email, presence: true
  validates :name,presence: true, length: {maximum: 20}
  validates :account, presence: true, uniqueness: true, length: {maximum: 20}
  validates :introduction, length: {maximum: 140}
  validates :password,length:{minimum: 6}, allow_nil: true
  validates :web, length: {maximum: 200}

  attr_accessor :current_password

  

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
