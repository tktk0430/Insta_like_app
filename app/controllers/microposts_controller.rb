class MicropostsController < ApplicationController
  before_action :login_user?
  def index
    redirect_to new_micropost_path
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

  private
    def micropost_params
      params.require(:micropost).permit(:content,:image)
    end
end
