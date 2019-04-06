class Micropost < ApplicationRecord
  include ImageUploader[:image]
  belongs_to :user
  default_scope->{order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, length:{maximum: 140}
  validates :image_data, presence: { message: "が選択されていません" }
end
