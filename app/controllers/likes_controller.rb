class LikesController < ApplicationController
  before_action :login_user?

  def create
    @micropost=Micropost.find(params[:micropost_id])
    current_user.like(@micropost)
    @micropost.create_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    like=current_user.active_like.find(params[:id])
    @micropost=like.micropost
    like.destroy
    @micropost.delete_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
end
