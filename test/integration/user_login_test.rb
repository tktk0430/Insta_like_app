require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "間違ったフォーマットでのログインは不可" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{user:{email:"", password: ""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  setup do
    @tom=users(:tom)
  end
  test "正しいフォーマットでのログインログアウトは可能" do
    get login_path
    assert_template 'sessions/new'
    assert_no_difference 'User.count' do
      post login_path, params:{user:{email:@tom.email, password:"password"}}
    end
    assert is_logged_in?
    assert_redirected_to @tom
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
  end
end
