require 'rails_helper'
RSpec.describe "User", type: :system do
  context '#new' do
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
end