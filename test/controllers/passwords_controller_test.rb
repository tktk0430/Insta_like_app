require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tom=users(:tom)
    @bob=users(:bob)
  end

  test "password#editはログイン必須" do
    get edit_password_path
    assert_not flash.empty?
    assert_redirected_to login_path
    login_as(@tom)
    get edit_password_path
    assert_template 'passwords/edit'
  end

  test "password#updateはログイン必須" do
    patch password_path, params:{user: {current_password: 'hogehoge',
                                        password: 'foobar',
                                        password_confirmation: 'foobar'}}
    assert_not flash.empty?
    assert_redirected_to login_path
    login_as(@tom)
    #current_password間違い
    patch password_path, params:{user: {current_password: 'ppaasswwoorrdd',
                                        password: 'foobar',
                                        password_confirmation: 'foobar'}}
    assert_template 'passwords/edit'
    #password & confirmation間違い
    patch password_path, params:{user: {current_password: 'password',
                                        password: 'foobarbar',
                                        password_confirmation: 'foobar'}}
    assert_template 'passwords/edit'
    #正しい変更
    patch password_path, params:{user: {current_password: 'password',
                                        password: 'foobar',
                                        password_confirmation: 'foobar'}}
    assert_not flash.empty?
    assert_redirected_to @tom
  end
end
