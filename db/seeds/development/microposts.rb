Micropost.create(
  content: "テストコンテンツ",
  user_id: 1
)

100.times do |i|
  Micropost.create(
    content: Yoshida::Text.sentence,
    user_id:i%12+1
  )
end