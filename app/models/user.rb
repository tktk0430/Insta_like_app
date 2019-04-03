class User < ApplicationRecord
  has_secure_password
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

  

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
