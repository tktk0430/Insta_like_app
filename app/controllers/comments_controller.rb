class CommentsController < ApplicationController
  include NotificationsHelper
  @@action_name="comment"
  before_action :login_user?

  def create
    comment=current_user.comments.new(micropost_id:params[:micropost_id],content: params[:comment][:content])
    @micropost=Micropost.find(params[:micropost_id])
    comment.save
    create_notification(micropost:@micropost,visited:@micropost.contributer,action_name:@@action_name,comment:comment.id)
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end

  def destroy
    comment=current_user.comments.find(params[:id])
    @micropost=comment.micropost
    comment.destroy
    delete_notification(micropost:@micropost,visited:@micropost.contributer,action_name:@@action_name)
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end
end
