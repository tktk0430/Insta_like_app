class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :account, presence: true
  validates :password_digest, presence: true

  

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  private

end
