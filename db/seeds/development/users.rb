User.create!(
  email: "taku@example.com",
  name: "広澤 拓",
  account: "master",
  introduction: "初めまして。このサイトの製作者です。ご覧いただきありがとうございます。ごゆるりとお過ごしください。",
  web: Faker::Internet.url,
  tel: Faker::PhoneNumber.phone_number,
  sex: 1,
  password: "password",
  password_confirmation: "password",
  admin: true,
  image: File.open("#{Rails.root}/db/thumb_image_seeds/master.jpg")
)
User.create!(
  email: "test@example.com",
  name: "テスト太郎",
  account: "tester",
  introduction: "初めまして。テストユーザーです。トップページの「かんたんログイン」で私にログインできます。",
  web: Faker::Internet.url,
  tel: Faker::PhoneNumber.phone_number,
  sex: 1,
  password: "password",
  password_confirmation: "password",
  admin: false,
  image: File.open("#{Rails.root}/db/thumb_image_seeds/tester.jpg")
)

image_num_array=[*1..10].shuffle!
10.times do |n|
  email="example-#{n}@example.com"
  name=Faker::Name.name
  account="user#{n}"
  password="password"
  image_num=image_num_array.shift
  User.create!(
    email: email,
    name: name,
    account: account,
    introduction: Yoshida::Text.sentences(1).join(""),
    web: Faker::Internet.url,
    tel: Faker::PhoneNumber.phone_number,
    sex: n%3,
    password: password,
    password_confirmation: password,
    image: File.open("#{Rails.root}/db/thumb_image_seeds/#{image_num}.jpg")
  )
end