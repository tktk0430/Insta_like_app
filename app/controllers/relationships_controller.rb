class RelationshipsController < ApplicationController
  before_action :login_user?
  #current_userであることを確かめる必要はない。(各々のアクションでcurrent_userからのactive_relationshipを探しているため)

  def create
    @rel=current_user.active_relationship.new(followed_id: params[:followed_id])
    @rel.save
    @user=User.find(params[:followed_id])
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    rel=current_user.active_relationship.find(params[:id])
    @user=User.find(rel.followed_id)
    rel.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end
end
