class NotificationsController < ApplicationController
  before_action :login_user?

  def index
    @user=current_user
    @notifications=Notification.where(visited_id:current_user.id).page(params[:page]).per(10)
  end
end
