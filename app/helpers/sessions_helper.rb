module SessionsHelper
  def current_user
    user_id=session[:user_id]
    @current_user=User.find_by(id:user_id)
  end

  def correct_user
    current_user==@user
  end

  def login(user)
    session[:user_id]=user.id
  end

  def logout
    session.delete(:user_id)
  end

  def login?
    !current_user.nil?
  end
end
