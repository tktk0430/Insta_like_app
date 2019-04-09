module LikesHelper
  def like_button
    if like?(@micropost)
      link_to 'いいね解除', like_path(params: {micropost_id: @micropost.id}), method: :delete, class:"btn btn-danger btn-block"
    else
      link_to 'いいね', likes_path(params: {micropost_id: @micropost.id}), method: :post, class:"btn btn-primary btn-block"
    end
  end

  private
    def like?(micropost)
      !current_user.active_like.find_by(micropost_id:micropost.id).nil?
    end
end
