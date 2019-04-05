require 'test_helper'

class PasswordChangeTest < ActionDispatch::IntegrationTest
  setup do
    @tom=users(:tom)
  end

  test "正しいフォーマットでのパスワード変更" do
    get edit_password_path
    assert_redirected_to login_path
    login_as(@tom)
    get edit_password_path
    assert_template "passwords/edit"
    assert_select "label[for=?]", "user_current_password"
    assert_select "label[for=?]", "user_password"
    assert_select "label[for=?]", "user_password_confirmation"
    patch password_path, params:{user:{current_password:"invalidpassword",
                                      password: "passwordsecond",
                                      password_confirmation:"passwordsecond"}}
    assert_template "passwords/edit"
    assert_select "#errors"
    patch password_path, params:{user:{current_password:"password",
                                        password: "wrongpassword",
                                        password_confirmation:"passwordsecond"}}
    assert_template "passwords/edit"
    assert_select "#errors"
    patch password_path, params:{user:{current_password:"password",
                                      password: "passwordsecond",
                                      password_confirmation:"passwordsecond"}}
    assert_redirected_to user_path(@tom)
    @tom.reload
    assert @tom.authenticate("passwordsecond")
  end
end
