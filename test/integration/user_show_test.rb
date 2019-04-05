require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  setup do
    @tom=users(:tom)
  end

  test "userのプロフィールには以下のものが含まれる" do
    login_as(@tom)
    get user_path(@tom)
    assert_select 'header'
    assert_select '.gravatar'
    assert_select "a[href=?]", edit_user_path(@tom)
    assert_select '.introduction'
    #assert_select 'follow_path' if not follow
    #assert_select 'unfollow_path' if follow
    #assert_match @user.microposts.count.to_s, response.body
    #assert_match @user.follow.count.to_s, response.body
    #assert_match @user.follower.count.to_s, response.body
    #postがあってそれぞれがpost_pathをもつ
  end
end
