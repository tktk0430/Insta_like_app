require 'rails_helper'

RSpec.describe "TestUsage", type: :system do
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