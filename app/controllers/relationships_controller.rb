class RelationshipsController < ApplicationController
  before_action :login_user?
  #current_userであることを確かめる必要はない。(各々のアクションでcurrent_userからのactive_relationshipを探しているため)

  def create
    rel=current_user.active_relationship.new(followed_id: params[:followed_id])
    rel.save
    redirect_to request.referrer || root_url
  end

  def destroy
    rel=current_user.active_relationship.find_by(followed_id: params[:followed_id])
    rel.destroy
    redirect_to request.referrer || root_url
  end
end
