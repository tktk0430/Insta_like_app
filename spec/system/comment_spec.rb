require 'rails_helper'

RSpec.describe "Comment", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  let(:bob_post){FactoryBot.create(:micropost,contributer:bob)}
  let(:tom_comment){FactoryBot.create(:comment,user:tom,micropost:bob_post,content:'ボブ、最高だよ')}

  context 'create(コメント)' do
    before do
      login(tom)
      bob_post
      visit user_path(bob)
      click_link href: micropost_path(bob_post)
    end

    scenario 'コメント成功' do
      within '.micropost-show' do
        expect(page).to have_button 'コメント'
        fill_in 'comment_content',with: '綺麗な写真ですね'
        click_button 'コメント'
        expect(page.body).to have_content '綺麗な写真ですね'
        expect(page).to have_link '削除'
      end
      login(bob)
      visit user_path(bob)
      click_link href: micropost_path(bob_post)
      within '.micropost-show' do
        expect(page.body).to have_content '綺麗な写真ですね'
        expect(page).not_to have_link '削除'
      end
    end
  end

  context 'destroy(コメント削除)' do
    before do
      login(tom)
      bob_post
      tom_comment
      visit user_path(bob)
      click_link href: micropost_path(bob_post)
    end

    scenario 'コメント削除成功' do
      within '.micropost-show' do
        expect(page.body).to have_content 'ボブ、最高だよ'
        expect(page).to have_link '削除'
        expect{click_link '削除'}.to change(Comment.all,:count).by(-1)
        expect(page.body).not_to have_content 'ボブ、最高だよ'
      end
    end
  end
end