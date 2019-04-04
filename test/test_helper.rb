ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def is_logged_in?
    !session[:user_id].nil?
  end

  def login_as(user)
    session[:user_id] = user.id
  end
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest #Integration Test用
  def login_as(user)
    post login_path, params: { user: { email: user.email,
                                          password: "password",
                                          } }
  end

  def update(user,name:user.name, account:user.account, email:user.email)
    
  end
end
