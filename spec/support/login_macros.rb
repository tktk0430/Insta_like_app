module LoginMacros
  def login(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
  end

  def logout(user)
    visit edit_user_path(user)
    click_link 'ログアウト'
  end
end