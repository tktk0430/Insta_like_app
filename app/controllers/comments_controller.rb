class CommentsController < ApplicationController
  include NotificationsHelper
  @@action_name="comment"
  before_action :login_user?

  def create
    comment=current_user.comments.new(micropost_id:params[:micropost_id],content: params[:comment][:content])
    @micropost=Micropost.find(params[:micropost_id])
    if comment.save
      comment.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  def destroy
    comment=current_user.comments.find(params[:id])
    @micropost=comment.micropost
    comment.destroy
    comment.delete_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end
end
