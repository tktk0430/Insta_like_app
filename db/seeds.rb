User.create!(
  email: "taku@example.com",
  name: "広澤 拓",
  account: "master",
  introduction: Faker::Lorem.sentence(20),
  web: Faker::Internet.url,
  tel: Faker::PhoneNumber.phone_number,
  sex: 1,
  password: "password",
  password_confirmation: "password",
  admin: true,
)
34.times do |n|
  email="example-#{n}@example.com"
  name=Faker::Name.name
  account="user#{n}"
  password="password"
  User.create!(
    email: email,
    name: name,
    account: account,
    introduction: Faker::Lorem.sentence(10),
    web: Faker::Internet.url,
    tel: Faker::PhoneNumber.phone_number,
    sex: n%3,
    password: password,
    password_confirmation: password
  )
end