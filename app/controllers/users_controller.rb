class UsersController < ApplicationController
  def index
    @users=User.page(params[:page]).per(10)
  end

  def show
    @user=User.find(params[:id])
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success]="ようこそ！"
      redirect_to users_path
    else
      render 'users/new'
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを編集しました"
      redirect_to @user
    else
      render 'users/edit'
    end
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