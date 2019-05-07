class RelationshipsController < ApplicationController
  before_action :login_user?

  def create
    followed=User.find(params[:followed_id])
    @rel=current_user.follow(followed)
    @user=User.find(params[:followed_id])
    @user.create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    rel=current_user.active_relationship.find(params[:id])
    @user=User.find(rel.followed_id)
    @user.delete_notification_by(current_user)
    rel.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end
end
