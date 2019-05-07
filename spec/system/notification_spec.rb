require 'rails_helper'

RSpec.describe "Notification", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  let(:bob_post){FactoryBot.create(:micropost,contributer:bob)}

  before do
    bob_post
    login(tom)
  end

  scenario 'フォロー、いいね、コメントの各アクションにより、通知が作られる。逆の動作も検証' do
    visit user_path(bob)
    expect{click_link 'フォロー'}.to change(bob.passive_notifications,:count).by(1)
    click_link href: micropost_path(bob_post)
    expect{click_link 'いいね'}.to change(bob.passive_notifications,:count).by(1)
    fill_in 'comment_content',with: '綺麗な写真ですね'
    expect{click_button 'コメント'}.to change(bob.passive_notifications,:count).by(1)
    visit user_path(bob)
    expect{click_link 'フォロー解除'}.to change(bob.passive_notifications,:count).by(-1)
    click_link href: micropost_path(bob_post)
    expect{click_link 'いいね解除'}.to change(bob.passive_notifications,:count).by(-1)
    expect{click_link '削除'}.to change(bob.passive_notifications,:count).by(-1)
  end

  scenario '送られた通知を一覧で見ることができる' do
    visit user_path(bob)
    expect{click_link 'フォロー'}.to change(bob.passive_notifications,:count).by(1)
    click_link href: micropost_path(bob_post)
    expect{click_link 'いいね'}.to change(bob.passive_notifications,:count).by(1)
    fill_in 'comment_content',with: '綺麗な写真ですね'
    expect{click_button 'コメント'}.to change(bob.passive_notifications,:count).by(1)
    logout(tom)
    login(bob)
    click_link '通知'
    expect(page.body).to have_content 'tomがあなたをフォローしました'
    expect(page.body).to have_content 'tomがあなたの投稿にいいね！しました'
    expect(page.body).to have_content 'tomがあなたの投稿にコメントしました'
    expect(page.body).to have_content '綺麗な写真ですね'
  end
end