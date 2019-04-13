class SearchesController < ApplicationController
  before_action :login_user?
  def index
    @user=current_user
    if params[:query].length>100
      @alert="検索ワードは100文字以下にしてください"
      render 'searches/new'
    elsif params[:query].blank?
      @alert="検索ワードをいれてください"
      render 'searches/new'
    else
      @microposts=Micropost.where("content LIKE ?","%#{params[:query]}%").page(params[:page]).per(12)
      @page_title="'#{params[:query]}'の検索結果"
    end
  end

  def new
  end

  def show
    redirect_to new_search_path
  end
end