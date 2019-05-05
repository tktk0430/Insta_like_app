require 'rails_helper'

RSpec.describe Comment, type: :model do
let(:comment){FactoryBot.create(:comment)}

  it 'のFactoryBotは正常に動く' do
    expect(comment).to be_valid
  end
  
  it 'はid降順に並ぶ' do
    comment1=FactoryBot.create(:comment)
    comment2=FactoryBot.create(:comment)
    comment3=FactoryBot.create(:comment)
    expect(Comment.first).to eq comment3
  end
  it 'はuserがないと無効' do
    comment.user=nil
    expect(comment).not_to be_valid
  end

  it 'はmicropostがないと無効' do
    comment.micropost=nil
    expect(comment).not_to be_valid
  end

  it 'は本文がないと無効' do
    comment.content=nil
    expect(comment).not_to be_valid
  end

  it 'は本文が長すぎると無効' do
    comment.content="a"*201
    expect(comment).not_to be_valid
  end

  describe 'コメント通知メソッド' do
    it 'によりコメント通知が作成・削除される' do
      user=FactoryBot.create(:user)
      comment.create_notification_by(user)
      notif=Notification.find_by(visiter_id:user.id,comment_id:comment.id)
      expect(notif).not_to be_nil
      comment.delete_notification_by(user)
      notif=Notification.find_by(visiter_id:user.id,comment_id:comment.id)
      expect(notif).to be_nil
    end
  end
end
