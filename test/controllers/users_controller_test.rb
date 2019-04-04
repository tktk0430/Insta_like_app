require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @tom=users(:tom)
    @bob=users(:bob)
  end

  test "デフォルトネームは名無しさん" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path,params:{user:{
                                account: "hogehoge",
                                email: "hogehoge@gmail.com",
                                password: "password",
                                password_confirmation: "password"}}
    end
    user=User.find_by(email: "hogehoge@gmail.com")
    assert_equal user.name, "名無しさん", "ユーザーネームは#{user.name}"
  end

  test "user#indexはログイン必須" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_path
    login_as(@tom)
    get users_path
    assert_template 'users/index'
  end

  test "user#showはログイン必須" do
    get user_path(@tom)
    assert_not flash.empty?
    assert_redirected_to login_path
    login_as(@tom)
    get user_path(@tom)
    assert_template 'users/show'
  end

  test "user#editはログインかつcorrect_user必須" do
    get edit_user_path(@tom)
    assert_not flash.empty?
    assert_redirected_to login_path
    login_as(@tom)
    get edit_user_path(@bob)
    assert_not flash.empty?
    assert_redirected_to root_path
    get edit_user_path(@tom)
    assert_template 'users/edit'
  end

  test "user#updateはログインかつcorrect_user必須" do
    patch user_path(@tom), params:{user:{name: "tomtom"}}
    assert_not flash.empty?
    assert_redirected_to login_path
    login_as(@tom)
    patch user_path(@bob), params:{user:{name: "tomtom"}}
    assert_not flash.empty?
    assert_redirected_to root_path
    patch user_path(@tom), params:{user:{name: "tomtom"}}
    assert_redirected_to @tom
    @tom.reload
    assert_equal "tomtom", @tom.name
  end

  test "user#destroyはログインかつcorrect_user必須" do
    delete user_path(@tom)
    assert_not flash.empty?
    assert_redirected_to login_path
    login_as(@tom)
    delete user_path(@bob)
    assert_not flash.empty?
    assert_redirected_to root_path
    assert_difference 'User.count', -1 do
      delete user_path(@tom)
    end
    assert_redirected_to root_path
  end
end
