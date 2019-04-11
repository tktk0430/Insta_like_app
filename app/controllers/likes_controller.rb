class LikesController < ApplicationController
  before_action :login_user?

  def create
    like=current_user.active_like.new(micropost_id:params[:micropost_id])
    like.save
    @micropost=Micropost.find(params[:micropost_id])
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    like=current_user.active_like.find(params[:id])
    @micropost=like.micropost
    like.destroy
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
end
