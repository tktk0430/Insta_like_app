class HomeController < ApplicationController
  include SessionsHelper
  
  def top
    current_user.nil? ? @user=User.new : @user=current_user
  end

  def about
  end
end
