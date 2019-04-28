FactoryBot.define do
  factory :user, aliases:[:contributer] do
    name {"test"}
    sequence(:account) {|n| "tester#{n}"}
    sequence(:email) {|n| "tester#{n}@gmail.com"}
    password {"hogehoge"}
    password_confirmation {"hogehoge"}
  end
end