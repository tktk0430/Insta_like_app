class MicropostsController < ApplicationController
  before_action :login_user?
  before_action :correct_user, only: :destroy

  def index
    redirect_to new_micropost_path
  end

  def show
    @micropost=Micropost.find(params[:id])
    @user=@micropost.contributer
  end

  def new
    @micropost=current_user.microposts.build
  end

  def create
    @micropost=current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "画像を投稿しました"
      redirect_to current_user
    else
      render 'new'
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
      params.require(:micropost).permit(:content,:image)
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
