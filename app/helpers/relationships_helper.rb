module RelationshipsHelper
  def following?(user)
    !current_user.active_relationship.find_by(followed_id:user.id).nil?
  end
end