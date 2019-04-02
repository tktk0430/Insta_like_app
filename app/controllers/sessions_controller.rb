class SessionsController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user=User.find_by(email:params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      @user.login
      flash[:success] = "ログインしました"
      redirect_to @user
    else
      binding.pry
      render 'sessions/new'
    end
  end

  def destroy
    @user.logout
    redirect_to root_path
  end
end
