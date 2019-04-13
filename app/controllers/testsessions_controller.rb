class TestsessionsController < ApplicationController
  def create
    @user=User.find_by(email:"test@example.com")
    if @user&.authenticate("password")
      session[:user_id] = @user.id
      flash[:success] = "ログインしました。このユーザーはプロフィール設定機能が一部制限されています。"
      redirect_to @user
    else
      @user=User.new
      flash.now[:danger]="メールアドレスとパスワードが一致しません"
      render 'sessions/new'
    end
  end
end
