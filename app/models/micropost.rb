class Micropost < ApplicationRecord
  include ImageUploader[:image]
  belongs_to :contributer, class_name:'User', foreign_key: 'user_id'
  default_scope->{order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, length:{maximum: 180}
  validates :image_data, presence: { message: "が選択されていません" }
end
