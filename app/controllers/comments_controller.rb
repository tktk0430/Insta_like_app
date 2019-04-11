class CommentsController < ApplicationController
  before_action :login_user?

  def create
    comment=current_user.comments.new(micropost_id:params[:micropost_id],content: params[:comment][:content])
    @micropost=Micropost.find(params[:micropost_id])
    comment.save
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end

  def destroy
    comment=current_user.comments.find(params[:id])
    @micropost=comment.micropost
    comment.destroy
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end
end
