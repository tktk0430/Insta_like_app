class User < ApplicationRecord
  has_secure_password
  with_options presence: true do
    validates :email
    validates :name
    validates :password_digest
  end
end
