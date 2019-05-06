require 'rails_helper'

RSpec.describe "User", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}

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
      unsubscribe = find_link '退会する'
      expect(unsubscribe['data-confirm']).to eq '本当に退会しますか'
      expect{
        click_link '退会する'
      }.to change(User.all,:count).by(-1)
    end
  end
end