class ApplicationController < ActionController::Base
  include SessionsHelper

  def login_user?
    unless login?
      flash[:danger]="ログインが必要です"
      redirect_to login_path
    end
  end

  def correct_user?
    user=User.find_by(id: params[:id])
    unless user==current_user
      flash[:danger]="このページにはアクセスできません"
      redirect_to root_path
    end
  end

  def set_default_micropost
    @micropost=Micropost.new
  end

end
