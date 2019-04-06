class MicropostsController < ApplicationController
  before_action :login_user?

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
      params.require(:micropost).permit(:content)
    end
end
