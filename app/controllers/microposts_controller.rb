class MicropostsController < ApplicationController
  before_action :login_user?
  before_action :correct_user, only: :destroy
  protect_from_forgery except: :create

  def index
    redirect_to new_micropost_path
  end

  def show
    @micropost=Micropost.find(params[:id])
    respond_to do |format|
      format.html { render 'microposts/_show' }
      format.js
    end
  end

  def new
    @micropost=current_user.microposts.build
    respond_to do |format|
      format.html { render 'microposts/_new' }
      format.js
    end
  end

  def create
    @micropost=current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "画像を投稿しました"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.html { render 'microposts/_new' }
        format.js
      end
    end
  end

  def destroy
    micropost=Micropost.find(params[:id])
    micropost.destroy
    flash[:info]="投稿を取り消しました"
    redirect_to micropost.contributer
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content,:image,:image_data)
    end

    def correct_user
      micropost=Micropost.find(params[:id])
      contributer=micropost.contributer
      unless current_user==contributer
        session[:danger] = "このページにはアクセスできません"
        redirect_to root_url
      end
    end
end
