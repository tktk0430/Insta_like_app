module LikesHelper
  private
    def like?(micropost)
      !current_user.active_like.find_by(micropost_id:micropost.id).nil?
    end
end
