class CommentsController < ApplicationController
  before_action :login_user?

  def create
    comment=current_user.comments.new(micropost_id:params[:micropost_id],content: params[:comment][:content])
    comment.save
    redirect_to request.referrer || root_url
  end

  def destroy
    comment=current_user.comments.find(params[:id])
    comment.destroy
    redirect_to request.referrer || root_url
  end
end
