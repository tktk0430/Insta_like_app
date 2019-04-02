User.create!(
  email: "taku@example.com",
  name: "広澤 拓",
  introduction: Yoshida::Text.sentence,
  password: "password",
  password_confirmation: "password",
  admin: true,
)
99.times do |n|
  email="example-#{n}@example.com"
  name=Faker::Name.name
  password="password"
  User.create!(
    email: email,
    name: name,
    introduction: Yoshida::Text.sentence,
    password: password,
    password_confirmation: password
  )
end