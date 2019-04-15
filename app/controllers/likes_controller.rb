class LikesController < ApplicationController
  include NotificationsHelper
  @@action_name="like"
  before_action :login_user?

  def create
    like=current_user.active_like.new(micropost_id:params[:micropost_id])
    like.save
    @micropost=Micropost.find(params[:micropost_id])
    create_notification(micropost:@micropost,visited:@micropost.contributer,action_name:@@action_name)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    like=current_user.active_like.find(params[:id])
    @micropost=like.micropost
    like.destroy
    delete_notification(micropost:@micropost,visited:@micropost.contributer,action_name:@@action_name)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
end
