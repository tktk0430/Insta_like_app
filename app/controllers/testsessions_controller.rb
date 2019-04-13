class TestsessionsController < ApplicationController
  def create
    user=User.find_by(email:"test@example.com")
    user&.authenticate("password")
    session[:user_id] = user.id
    flash[:success] = "テストユーザとしてログインしました。"
    redirect_to user
  end
end
