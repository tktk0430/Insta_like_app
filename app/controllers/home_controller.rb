class HomeController < ApplicationController
  include SessionsHelper
  
  def top
    @user=current_user
  end

  def about
  end
end
