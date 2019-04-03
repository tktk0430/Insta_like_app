class SessionsController < ApplicationController
  include SessionsHelper

  def new
    @user=User.new
  end

  def create
    @user=User.find_by(email:params[:sessions][:email])
    if @user&.authenticate(params[:sessions][:password])
      session[:user_id] = @user.id
      flash[:success] = "ログインしました"
      redirect_to @user
    else
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
