require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user=User.new(
      email: "example@gmail.com",
      name: "Test User",
      account: "test",
      password: "password",
      password_confirmation: "password"
    )
  end

  test "setupのユーザーは正しい" do
    assert @user.valid?
  end

  test "emailは空白不可" do
    @user.email=""
    assert_not @user.valid?
  end

  test "emailは200文字以下" do
    @user.email="a"*200 + "@gmail.com"
    assert_not @user.valid?
  end

  test "emailのフォーマットは/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i" do
    INVALID_EMAIL_LIST=%w(hogehoge@@gmail.com hogehoge@gmail. @gmail.com aaagmail.com)
    INVALID_EMAIL_LIST.each do |inv|
      @user.email=inv
      assert_not @user.valid?
    end
  end

  test "emailは一意" do
    other = @user.clone
    other.account= 'other'
    assert other.valid?
    @user.save
    assert_not other.valid?
  end

  test "nameは空白不可" do
    @user.name=""
    assert_not @user.valid?
  end

  test "nameは20文字以内" do
    @user.name="a"*21
    assert_not @user.valid?
  end

  test "accountは空白不可" do
    @user.account = ""
    assert_not @user.valid?
  end

  test "accountは一意" do
    other=@user.clone
    other.email="foobar@gmail.com"
    assert other.valid?
    @user.save
    assert_not other.valid?
  end

  test "accountは20文字以内" do
    @user.account="a"*21
    assert_not @user.valid?
  end

  test "introductionは200字以内" do
    @user.introduction = "a"*201
    assert_not @user.valid?
  end

  test "passwordは6文字以上" do
    @user.password = "foo"
    assert_not @user.valid?
  end

  test "webは200字以内" do
    @user.web = "https://"+"a"*200
    assert_not @user.valid?
  end
end
