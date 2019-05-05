require 'rails_helper'

RSpec.describe Micropost, type: :model do
  it "のFactoryBotは正常に動く" do
    post=FactoryBot.build(:micropost)
    expect(post).to be_valid
  end

  it "はid降順に並ぶ" do
    post1=FactoryBot.create(:micropost)
    post2=FactoryBot.create(:micropost)
    post3=FactoryBot.create(:micropost)
    expect(Micropost.first).to eq post3
  end

  it "は本文が長すぎると無効" do
    post=FactoryBot.build(:micropost,content:'a'*241)
    expect(post).not_to be_valid
  end

  it "は本文がなくても有効" do
    post=FactoryBot.build(:micropost,content:'')
    expect(post).to be_valid
  end

  it "は画像がないと無効" do
    post=FactoryBot.build(:micropost,image:nil)
    expect(post).not_to be_valid
  end

  describe 'いいね！通知メソッド' do
    it "によりいいね！通知が送られる＆削除される" do
      user=FactoryBot.create(:user)
      another=FactoryBot.create(:user)
      micropost=FactoryBot.create(:micropost,contributer:another)
      micropost.create_notification_by(user)
      notif=Notification.find_by(visiter:user.id,micropost:micropost.id)
      expect(notif).not_to be_nil
      micropost.delete_notification_by(user)
      notif=Notification.find_by(visiter:user.id,micropost:micropost.id)
      expect(notif).to be_nil
    end
  end
end
