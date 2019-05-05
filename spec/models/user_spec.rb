require 'rails_helper'

RSpec.describe User, type: :model do
  it "のFactoryBotは正常に動く" do
    ur=FactoryBot.build(:user)
    expect(FactoryBot.build(:user)).to be_valid
  end

  before do
    @user=FactoryBot.create(:user)
    @another=FactoryBot.create(:user)
  end

  

  it "はaccount,email,passwordがあれば有効" do
    expect(@user).to be_valid
  end

  it "は名前がなければ無効" do
    @user.name=nil
    @user.valid?
    expect(@user.errors[:name]).to include("を入力してください")
  end

  it "は名前が長すぎると無効" do
    @user.name="a"*21
    @user.valid?
    expect(@user.errors[:name]).to include("は20文字以内で入力してください")
  end

  it "はアカウント名がないと無効" do
    @user.account=nil
    @user.valid?
    expect(@user.errors[:account]).to include("を入力してください")
  end

  it "はアカウント名が被っていると無効" do
    @another.account=@user.account
    @another.valid?
    expect(@another.errors[:account]).to include("はすでに存在します")
  end

  it "はパスワードがないと無効" do
    @user.password=nil
    @user.valid?
    expect(@user.errors[:password]).to include("を入力してください")
  end

  it "は確認用のパスワードとパスワードが一致してないと無効" do
    @user.password_confirmation="test"
    @user.valid?
    expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

  it "はemailがないと無効" do
    @user.email=nil
    @user.valid?
    expect(@user.errors[:email]).to include "を入力してください"
  end

  it "はemailが被っていると無効" do
    @another.email=@user.email
    @another.valid?
    expect(@another.errors[:email]).to include("はすでに存在します")
  end

  it "はemailが不正な文字列だと無効" do
    invalid_emails=%w(@@@gmail.com hogehogegmail.com hoge@gmail)
    invalid_emails.each do |email|
      @user.email=email
      @user.valid?
      expect(@user.errors[:email]).to include("は不正な値です")
    end
  end

  it "はemailが長すぎると無効" do
    @user.email="a"*201+"@gmail.com"
    @user.valid?
    expect(@user.errors[:email]).to include("は200文字以内で入力してください")
  end

  it "は自己紹介が長すぎると無効" do
    @user.introduction="a"*241
    @user.valid?
    expect(@user.errors[:introduction]).to include("は240文字以内で入力してください")
  end

  describe "フォロー通知メソッド" do
    it "によりフォロー通知が作られる" do
      @another.create_notification_by(@user)
      notif=Notification.find_by(visiter_id:@user.id,visited_id:@another.id)
      expect(notif).not_to be_nil
      @another.delete_notification_by(@user)
      notif=Notification.find_by(visiter_id:@user.id,visited_id:@another.id)
      expect(notif).to be_nil
    end
  end
end
