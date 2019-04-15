class SessionsController < ApplicationController
  include SessionsHelper

  def new
    @user=User.new
  end

  def create
    @user=User.find_by(email:params[:user][:email])
    @micropost=Micropost.new
    if @user&.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = "ログインしました"
      redirect_to @user
    else
      @user=User.new
      flash.now[:danger]="メールアドレスとパスワードが一致しません"
      render 'sessions/new'
    end
  end

  def destroy
    logout
    flash[:info] = "ログアウトしました"
    redirect_to root_path
  end
end
