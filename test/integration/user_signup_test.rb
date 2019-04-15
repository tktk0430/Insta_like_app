require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "正しくないフォーマットでの新規登録は不可" do
    get signup_path
    assert 'users/new'
    post users_path, params:{user:{
                              name:"",
                              account:"",
                              email:"",
                              password:"",
                              password_confirmation:""}}
    assert 'users/new'
    assert_select '#errors'
  end

  test "正しいフォーマットでの新規登録は可能" do
    get signup_path
    assert 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params:{user:{
                              name:"",
                              account:"hogehoge",
                              email:"hogefuga@gmail.com",
                              password:"foobar",
                              password_confirmation:"foobar"}}
    end
    user=assigns(:user)
    assert_redirected_to user_path(user)
    assert_equal user.name, "名無しさん"
  end
end
