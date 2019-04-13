class TestusersController < ApplicationController
  require "date"

  def create
    account=DateTime.now.to_time.to_i
    @user=User.new(name: "ご新規様", 
                  account: "new#{account}", 
                  introduction: "登録日：#{Date.today}",
                  email: "#{account}@example.com",
                  password:"password",
                  password_confirmation:"password")
    if @user.save
      login(@user)
      flash[:success]="ようこそ！Passwordは'password'です"
      redirect_to @user
    else
      render 'users/new'
    end
  end
end
