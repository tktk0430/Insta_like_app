require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  setup do
    @tom=users(:tom)
    @bob=users(:bob)
  end

  test "home/topのログイン状態によるビュー確認" do
    get root_path
    assert_template "home/top"
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    login_as(@tom)
    assert_redirected_to @tom
    get root_path
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", user_path(@tom)
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_template "home/top"
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
  end
end
