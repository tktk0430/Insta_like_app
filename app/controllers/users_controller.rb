class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user=User.new(name:"No name")
  end

  def create
    @user=User.new(user_params)
    binding.pry
    if @user.save
      redirect_to @user, notice: "ようこそ！"
    else
      render 'users/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation
      )
    end
end