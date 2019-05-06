require 'rails_helper'
RSpec.describe "Session", type: :system do
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
end