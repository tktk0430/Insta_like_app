FactoryBot.define do
  factory :like do
    association :user
    association :micropost
  end
end
