require 'rails_helper'

RSpec.describe "TopPageScenarios", type: :system do
  context '新規登録' do
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

  context 'ログイン' do
    #デフォルト画像を持ったユーザーを作るため
    before do
      visit root_path
      click_link '新規登録'
      fill_in '名前', with: 'newname'
      fill_in 'ユーザーネーム', with: 'newaccount'
      fill_in 'メールアドレス', with: 'newmail@example.com'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認用）', with:'hogehoge'
      click_button '新規登録'
      click_link '設定'
      click_link 'ログアウト'
      @user=User.find_by(email:'newmail@example.com')
    end

    scenario '成功' do
      visit root_path
      click_link 'ログイン'
      fill_in 'メールアドレス', with: 'newmail@example.com'
      fill_in 'パスワード', with: 'hogehoge'
      expect{click_button 'ログイン'}.to change {current_path}.to(user_path(@user))
    end

    scenario '失敗' do
      visit root_path
      click_link 'ログイン'
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: 'hogehoge'
      expect{click_button 'ログイン'}.to_not change {current_path}
      expect(page).to have_content 'メールアドレスとパスワードが一致しません'
    end
  end

  context 'かんたん新規登録' do
    scenario '成功' do
      visit root_path
      expect{click_link 'かんたん新規登録'}.to change(User.all,:count).by(1)
      user=User.first
      expect(user.name).to include 'ご新規さま'
      expect(current_path).to eq user_path(user)
    end
  end

  context 'かんたんログイン' do
    before do
      visit root_path
      click_link '新規登録'
      fill_in '名前', with: 'テスト太郎'
      fill_in 'ユーザーネーム', with: 'tester'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with:'password'
      click_button '新規登録'
      click_link '設定'
      click_link 'ログアウト'
      @tester=User.find_by(email:'test@example.com')
    end

    scenario '成功' do
      visit root_path
      expect{click_link 'かんたんログイン'}.to change{current_path}.to(user_path(@tester))
    end
  end
end