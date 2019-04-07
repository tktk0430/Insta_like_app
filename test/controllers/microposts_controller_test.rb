require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @micropost = microposts(:first)
    @tom=users(:tom)
    @bob=users(:bob)
  end

  test "should redirect index,show,new,create,destroy when not log in" do
    get microposts_path
    assert_redirected_to login_path
    get micropost_path(@micropost)
    assert_redirected_to login_path
    get new_micropost_path
    assert_redirected_to login_path
    assert_no_difference 'Micropost.count' do
      post microposts_path, params:{micropost:{content: "hogehoge"}}
    end
    assert_redirected_to login_url
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy if not by correct user" do
    login_as(@bob)
    assert_no_difference "Micropost.count" do
      delete micropost_path(@micropost)
    end
    assert_redirected_to root_url
  end
end
