class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :name, presence: true
  validates :password_digest, presence: true
end
