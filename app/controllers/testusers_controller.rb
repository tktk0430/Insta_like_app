class TestusersController < ApplicationController
  require "date"

  def create
    account=DateTime.now.to_time.to_i
    @user=User.new(name: "ご新規さま", 
                  account: "new#{account}", 
                  introduction: "登録日：#{Date.today}",
                  email: "#{account}@example.com",
                  password:"password",
                  password_confirmation:"password",
                  image: File.open("#{Rails.root}/db/thumb_image_seeds/default.jpg"))
    if @user.save
      login(@user)
      flash[:success]="ようこそ！Passwordは'password'です"
      redirect_to @user
    else
      render 'users/new'
    end
  end
end
