require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  setup do
    @tom=users(:tom)
    @bob=users(:bob)
    @test_image=Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'tapir.jpg'), 'image/jpeg')
  end

  test 'ログイン〜投稿画面〜投稿〜確認〜削除' do
    login_as(@tom)
    assert_redirected_to @tom
    follow_redirect!
    #新規投稿ボタンの確認
    assert_select 'a[href=?]', new_micropost_path
    #新規投稿画面の確認
    get new_micropost_path
    assert_select 'a[href=?]', new_micropost_path, count:0
    assert_select 'input#micropost_image'
    assert_select 'textarea#micropost_content'
    assert_select 'input[type=?]', "submit"
    assert_select 'a[href=?]', user_path(@tom)
    #投稿の確認（エラーと正常時)
    assert_no_difference 'Micropost.count' do
      post microposts_path, params:{micropost:{image:"",content:"hoge"}}
    end
    assert_template 'microposts/new'
    assert_select '#errors'
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params:{micropost:{image: @test_image, content:""}}
    end
    assert_redirected_to @tom
    follow_redirect!
    assert_not flash.nil?
    #投稿反映の確認
    microposts=@tom.microposts
    microposts.each do |micropost|
      assert_match micropost.image[:small].url, response.body
    end
    #投稿詳細の確認
    first_micropost=@tom.microposts.first
    get micropost_path(first_micropost)
    assert_template 'microposts/show'
    #投稿削除の確認
    assert_select 'a' , text: '投稿を取り消す'
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    #他の人の投稿は削除できない
    other_micropost=@bob.microposts.first
    get micropost_path(other_micropost)
    assert_template 'microposts/show'
    assert_select 'a' , text: '投稿を取り消す', count:0
    assert_no_difference 'Micropost.count' do
      delete micropost_path(other_micropost)
    end
    assert_redirected_to root_path
  end
end
