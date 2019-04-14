class TestusersController < ApplicationController
  require "date"

  def create
    account=DateTime.now.to_time.to_i
    @user=User.new(name: "ご新規さま#{account}", 
                  account: "new#{account}", 
                  introduction: "わたしのメールアドレスは#{account}@example.com、パスワードはpasswordです。色々投稿してくださると幸いです！",
                  email: "#{account}@example.com",
                  password:"password",
                  password_confirmation:"password",
                  image: File.open("#{Rails.root}/db/thumb_image_seeds/default.jpg"))
    if @user.save
      login(@user)
      flash[:success]="ようこそ！"
      redirect_to @user
    else
      render 'users/new'
    end
  end
end
