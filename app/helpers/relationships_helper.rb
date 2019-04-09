module RelationshipsHelper
  def follow_button
    if following?(@user)
      link_to 'フォロー解除', relationship_path(params:{followed_id:@user.id}), method: :delete, class:"btn btn-danger btn-block"
    else
      link_to 'フォロー', relationships_path(params:{followed_id:@user.id}), method: :post, class:"btn btn-primary btn-block"
    end
  end

  private
    def following?(user)
      !current_user.active_relationship.find_by(followed_id:user.id).nil?
    end
end