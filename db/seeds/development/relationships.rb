12.times do |follower|
  (follower+1..12).each do |followed|
    Relationship.create(follower_id:follower, followed_id:followed)
  end
end