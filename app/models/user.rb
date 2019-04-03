class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :account, presence: true
  validates :password_digest, presence: true

  def login
    session[:user_id]=self.id
  end

  def logout
    session.delete(:user_id)
  end

  private

end
