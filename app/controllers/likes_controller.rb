class LikesController < ApplicationController
  before_action :login_user?

  def create
    like=current_user.active_like.new(micropost_id:params[:micropost_id])
    like.save
    redirect_to request.referrer || root_url
  end

  def destroy
    like=current_user.active_like.find_by(micropost_id:params[:micropost_id])
    like.destroy
    redirect_to request.referrer || root_url
  end
end
