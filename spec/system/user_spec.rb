require 'rails_helper'

RSpec.describe "User", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  let(:alice){FactoryBot.create(:user,name:'alice')}

  context 'new(新規登録)' do
    scenario '成功：名前入力あり' do
      visit root_path
      click_link '新規登録'
      fill_in '名前', with: 'newname'
      fill_in 'ユーザーネーム', with: 'newaccount'
      fill_in 'メールアドレス', with: 'newmail@example.com'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認用）', with:'hogehoge'
      expect{
        click_button '新規登録'
      }.to change(User.all, :count).by(1)
      newest_user=User.first
      expect(newest_user.name).to eq('newname')
    end
  
    scenario '成功：名前入力なし（名無しさんで登録）' do
      visit root_path
      click_link '新規登録'
      fill_in '名前', with: ''
      fill_in 'ユーザーネーム', with: 'newaccount'
      fill_in 'メールアドレス', with: 'newmail@example.com'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認用）', with:'hogehoge'
      expect{
        click_button '新規登録'
      }.to change(User.all, :count).by(1)
      newest_user=User.first
      expect(newest_user.name).to eq('名無しさん')
    end

    scenario '失敗：必須入力漏れ' do
      visit root_path
      click_link '新規登録'
      fill_in '名前', with: ''
      fill_in 'ユーザーネーム', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（確認用）', with:''
      expect{
        click_button '新規登録'
      }.not_to change(User.all, :count)
    end
  end

  context 'show(ユーザー詳細)' do
    before do
      2.times do |n|
        FactoryBot.create(:micropost,contributer: tom)
        FactoryBot.create(:micropost,contributer: bob)
      end
    end

    scenario 'ログインしていなければログイン画面にリダイレクト' do
      visit user_path(tom)
      expect(current_path).to eq login_path
    end

    scenario 'ログインしていればマイページを表示する。' do
      login(tom)
      visit user_path(tom)
      expect(current_path).to eq user_path(tom)
    end

    scenario '自分のページには設定変更リンクがあり、他人のページにはない' do
      login(tom)
      visit user_path(tom)
      expect(page).to have_link href: edit_user_path(tom)
      visit user_path(bob)
      expect(page).not_to have_link href: edit_user_path(bob)
    end

    scenario '投稿した画像が一覧で表示され、画像は詳細ページへのリンクをもつ' do
      login(tom)
      visit user_path(tom)
      tom.microposts.each do |micropost|
        expect(page).to have_link href: micropost_path(micropost)
      end
      visit user_path(bob)
      bob.microposts.each do |micropost|
        expect(page).to have_link href: micropost_path(micropost)
      end
    end
  end

  context 'edit(ユーザー編集)' do
    scenario 'ログインしていなければログイン画面にリダイレクト' do
      visit edit_user_path(tom)
      expect(current_path).to eq login_path
    end

    scenario '自分以外のユーザーは編集できない' do
      login(tom)
      visit edit_user_path(bob)
      expect(current_path).not_to eq edit_user_path(bob)
    end

    scenario '正しい情報での変更は有効' do
      login(tom)
      visit user_path(tom)
      click_link '設定'
      fill_in '名前', with: 'neo_tom'
      click_button '更新する'
      expect(tom.reload.name).to eq 'neo_tom'
    end

    scenario '誤った情報での変更は無効' do
      ORIGINAL_TOM_EMAIL=tom.email
      login(tom)
      visit user_path(tom)
      click_link '設定'
      fill_in 'メールアドレス', with: '@@@@@@@@@@'
      click_button '更新する'
      expect(current_path).to eq user_path(tom)
      expect(page).to have_content("メールアドレスは不正な値です")
      expect(tom.email).to eq ORIGINAL_TOM_EMAIL
    end
  end

  context 'destroy(退会)', type: :system do
    scenario '退会成功' do
      visit root_path
      login(tom)
      visit user_path(tom)
      click_link '設定'
      expect{click_link '退会する'}.to change(User.all, :count).by(-1)
      expect(current_path).to eq root_path
    end
  end

  context 'following (フォロー一覧)' do
    before do
      login(tom)
      tom.follow(alice)
      tom.follow(bob)
    end

    scenario '自分のページにはフォローしている人の数が表示され、それを押すとフォローしている人一覧が表示される' do
      visit user_path(tom)
      expect(page.body).to have_content "フォロー #{tom.following.count}"
      click_link "フォロー #{tom.following.count}"
      expect(current_path).to eq following_user_path(tom)
      tom.following.each do |following|
        expect(page.body).to have_content following.name
      end
    end
  end

  context 'followers (フォロワー一覧)' do
    before do
      login(tom)
      alice.follow(tom)
      bob.follow(tom)
    end

    scenario '自分のページにはフォロワーの数が表示され、それを押すとフォロワー一覧が表示される' do
      visit user_path(tom)
      expect(page.body).to have_content "フォロワー #{tom.followers.count}"
      click_link "フォロワー #{tom.followers.count}"
      expect(current_path).to eq followers_user_path(tom)
      tom.followers.each do |follower|
        expect(page.body).to have_content follower.name
      end
    end
  end
end