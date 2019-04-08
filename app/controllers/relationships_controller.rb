class RelationshipsController < ApplicationController
  def create
    rel=current_user.active_relationship.new(followed_id: params[:followed_id])
    if rel.save
      redirect_to request.referrer || root_url
    else
      flash[:danger]="作成できませんでした"
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    rel=current_user.active_relationship.find_by(followed_id: params[:followed_id])
    rel.destroy
    redirect_to request.referrer || root_url
  end
end
