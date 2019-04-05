require 'test_helper'

class UserUpdateTest < ActionDispatch::IntegrationTest
  setup do
    @tom=users(:tom)
  end

  test "正しくないフォーマットでのuser#updateは失敗する" do
    get edit_user_path(@tom)
    assert_redirected_to login_path
    login_as(@tom)
    get edit_user_path(@tom)
    assert_template "users/edit"
    patch user_path(@tom), params:{user:{name:"",
                                        account: "",
                                        introduction: "test",
                                        web:"test",
                                        tel: "test"}}
    assert_template "users/edit"
    assert_select "#errors"
  end

  test "正しいフォーマットでのuser#updateは成功する" do
    login_as(@tom)
    get edit_user_path(@tom)
    assert_template "users/edit"
    patch user_path(@tom), params:{user:{name:"michael aaron",
                                  account: "mic",
                                  introduction: "test",
                                  web:"test",
                                  tel: "test"}}
    assert_redirected_to user_path(@tom)
    @tom.reload
    assert_equal @tom.name, "michael aaron"
  end
end
