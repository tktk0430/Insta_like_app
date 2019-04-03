module HomeHelper
  def header_logo_path
    login? ? user_path(current_user) : root_path
  end
end
