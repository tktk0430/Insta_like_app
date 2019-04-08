require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  setup do
    @tom = users(:tom)
    @micropost=@tom.microposts.build(content: "hogehoge",
                                    image: Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'tapir.jpg'), 'image/jpeg'))
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test "user id should be present" do
    assert_not @micropost.user_id.nil?
  end

  test "content can be blank" do
    @micropost.content=""
    assert @micropost.valid?
  end

  test "content should not be too long" do
    @micropost.content="a" * 181
    assert_not @micropost.valid?
  end

  test "order should be descent" do
    assert_equal microposts(:first), Micropost.first
  end
end
