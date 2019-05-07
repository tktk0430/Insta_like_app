require 'rails_helper'

RSpec.describe "Micropost", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  let(:tom_post){FactoryBot.create(:micropost,contributer:tom)}
  let(:bob_post){FactoryBot.create(:micropost,contributer:bob)}
  
  context 'new(新規投稿)' do
    before do
      login(tom)
      click_link '新規投稿'
    end

    scenario '成功' do
      expect(page.body).to have_css('form#new_micropost')
      file_path = Rails.root.join('spec', 'fixtures', 'test.jpg')
      attach_file "micropost[image]", file_path
      fill_in '本文', with: 'テスト投稿です。'
      expect{click_button '投稿する'}.to change(Micropost.all, :count).by(1)
      expect(page.body).to have_content '画像を投稿しました'
      expect(Micropost.first.content).to eq 'テスト投稿です。'
    end

    scenario '失敗:画像なし' do
      fill_in '本文', with: 'テスト投稿です。'
      expect{click_button '投稿する'}.not_to change(Micropost.all, :count)
      expect(page.body).to have_content '画像が選択されていません'
    end

    scenario '失敗:画像の種類が不適' do
      file_path = Rails.root.join('spec', 'fixtures', 'test.rb')
      attach_file "micropost[image]", file_path
      fill_in '本文', with: 'テスト投稿です。'
      expect{click_button '投稿する'}.not_to change(Micropost.all, :count)
      expect(page.body).to have_content '画像が選択されていません'
    end
  end

  context 'show(画像詳細)' do
    before do
      login(tom)
      tom_post
    end

    scenario 'マイページから画像をクリックして詳細を開く' do
      visit user_path(tom)
      expect(page.body).to include tom_post.image[:small].id
      expect(page).to have_link href: micropost_path(tom_post)
      click_link href: micropost_path(tom_post)
      expect(page.body).to have_css('.micropost-show')
      expect(page.body).to include tom_post.image[:large].id
    end
  end

  context 'destroy(投稿削除)' do
    before do
      login(tom)
      tom_post
      bob_post
    end

    scenario 'tomはtomの投稿を消すことができる' do
      visit user_path(tom)
      click_link href: micropost_path(tom_post)
      expect(page.body).to include tom_post.image[:large].id
      expect(page.body).to have_link '投稿を取り消す'
      expect{click_link '投稿を取り消す'}.to change(Micropost.all,:count).by(-1)
    end

    scenario 'tomはbobの投稿を消すことができない' do
      visit user_path(bob)
      click_link href: micropost_path(bob_post)
      expect(page.body).to include bob_post.image[:large].id
      expect(page.body).not_to have_link '投稿を取り消す'
    end
  end
end