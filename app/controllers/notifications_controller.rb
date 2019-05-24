class NotificationsController < ApplicationController
  before_action :login_user?

  def index
    @user=current_user
    @notifications=current_user.passive_notifications.page(params[:page]).per(10).includes(:visiter,:micropost)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
