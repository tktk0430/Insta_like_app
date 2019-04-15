class RelationshipsController < ApplicationController
  include NotificationsHelper
  @@action_name="follow"
  before_action :login_user?

  def create
    @rel=current_user.active_relationship.new(followed_id: params[:followed_id])
    @rel.save
    @user=User.find(params[:followed_id])
    create_notification(visited:@user,action_name:@@action_name)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    rel=current_user.active_relationship.find(params[:id])
    @user=User.find(rel.followed_id)
    delete_notification(visited:@user,action_name:@@action_name)
    rel.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end
end
