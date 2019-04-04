User.create!(
  email: "taku@example.com",
  name: "広澤 拓",
  account: "master",
  introduction: Yoshida::Text.sentences(1).join(""),
  web: Faker::Internet.url,
  tel: Faker::PhoneNumber.phone_number,
  sex: 1,
  password: "password",
  password_confirmation: "password",
  admin: true,
)
User.create!(
  email: "test@example.com",
  name: "テスト太郎",
  account: "tester",
  introduction: Yoshida::Text.sentences(1).join(""),
  web: Faker::Internet.url,
  tel: Faker::PhoneNumber.phone_number,
  sex: 1,
  password: "password",
  password_confirmation: "password",
  admin: false,
)
33.times do |n|
  email="example-#{n}@example.com"
  name=Faker::Name.name
  account="user#{n}"
  password="password"
  User.create!(
    email: email,
    name: name,
    account: account,
    introduction: Yoshida::Text.sentences(1).join(""),
    web: Faker::Internet.url,
    tel: Faker::PhoneNumber.phone_number,
    sex: n%3,
    password: password,
    password_confirmation: password
  )
end