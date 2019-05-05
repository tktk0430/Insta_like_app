FactoryBot.define do
  factory :comment do
    association :user
    association :micropost
    content {'hogehoge'}
  end
end
