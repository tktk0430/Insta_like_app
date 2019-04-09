class Micropost < ApplicationRecord
  include ImageUploader[:image]
  default_scope->{order(created_at: :desc)}

  belongs_to :contributer, class_name:'User', foreign_key: 'user_id'
  has_many :passive_like, class_name: "Like"
  has_many :like_users, through: :passive_like, source: :user
  
  validates :user_id, presence: true
  validates :content, length:{maximum: 180}
  validates :image_data, presence: { message: "が選択されていません" }
end
