image_num_array=[*1..62].shuffle!

User.all.each do |user|
  5.times do |i|
    image_num=image_num_array.shift
    user.microposts.create(
      content: Yoshida::Text.sentence,
      image: File.open("#{Rails.root}/db/image_seeds/#{image_num}.jpg")
    )
  end
end