require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "home#topのテンプレート確認" do
    get root_path
    assert_template 'home/top'
    assert_select 'title', 'Images'
  end

  test "home#aboutのテンプレート確認" do
    get about_path
    assert_template 'home/about'
    assert_select 'title', 'About | Images'
  end
end
