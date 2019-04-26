require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user=User.create(
      name:"test",
      account:"tester",
      email:"tester@gmail.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    @another=User.create(
      name:"another",
      account:"another",
      email:"another@gmail.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  it "is valid with a first name, email, account, and password" do
    expect(@user).to be_valid
  end

  it "is invalid without name" do
    @user.name=nil
    @user.valid?
    expect(@user.errors[:name]).to include("を入力してください")
  end

  it "is invalid with too long name" do
    @user.name="a"*21
    @user.valid?
    expect(@user.errors[:name]).to include("は20文字以内で入力してください")
  end

  it "is invalid without account" do
    @user.account=nil
    @user.valid?
    expect(@user.errors[:account]).to include("を入力してください")
  end

  it "is invalid with duplicated account" do
    @another.account=@user.account
    @another.valid?
    expect(@another.errors[:account]).to include("はすでに存在します")
  end

  it "is invalid without password" do
    @user.password=nil
    @user.valid?
    expect(@user.errors[:password]).to include("を入力してください")
  end

  it "is invalid without email" do
    @user.email=nil
    @user.valid?
    expect(@user.errors[:email]).to include "を入力してください"
  end

  it "is invalid with duplicated email" do
    @another.email=@user.email
    @another.valid?
    expect(@another.errors[:email]).to include("はすでに存在します")
  end

  it "is invalid with duplicated email" do
    invalid_emails=%w(@@@gmail.com hogehogegmail.com hoge@gmail)
    invalid_emails.each do |email|
      @user.email=email
      @user.valid?
      expect(@user.errors[:email]).to include("は不正な値です")
    end
  end

  it "is invalid with too long email" do
    @user.email="a"*201+"@gmail.com"
    @user.valid?
    expect(@user.errors[:email]).to include("は200文字以内で入力してください")
  end

  it "is invalid with too long introduction" do
    @user.introduction="a"*241
    @user.valid?
    expect(@user.errors[:introduction]).to include("は240文字以内で入力してください")
  end

  describe "notification methods" do
    it "create and delete a notification from user to another" do
      @another.create_notification_by(@user)
      notif=Notification.find_by(visiter_id:@user.id,visited_id:@another.id)
      expect(notif).not_to be_nil
      @another.delete_notification_by(@user)
      notif=Notification.find_by(visiter_id:@user.id,visited_id:@another.id)
      expect(notif).to be_nil
    end
  end
end
