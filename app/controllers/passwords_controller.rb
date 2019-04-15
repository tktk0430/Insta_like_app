class PasswordsController < ApplicationController
  before_action :login_user?
  before_action :reject_test_user

  def show #update失敗時のurlをgetしたときのルーティングエラー回避
    redirect_to edit_password_path(current_user)
  end

  def edit
    @user=current_user
  end

  def update
    @user=current_user
    if @user&.authenticate(params[:user][:current_password])
      if @user.update_attributes(user_params)
        flash[:success] = 'パスワードを変更しました'
        redirect_to @user
      else
        render "edit"
      end
    else
      @user.errors.add(:current_password, :wrong)
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end

    def reject_test_user
      if current_user.email=="test@example.com"
        flash[:danger]="テストユーザーは機能が制限されています"
        redirect_to root_path 
      end
    end
end
