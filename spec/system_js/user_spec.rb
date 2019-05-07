require 'rails_helper'

RSpec.describe "User", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}

  before do
    skip '非常に時間がかかるため、最終確認時以外はskip'
  end

  context 'destroy(退会):js', type: :system, js: true do
    scenario '退会成功' do
      skip 'Too slow test'
      visit root_path
      login(tom)
      visit user_path(tom)
      INITIAL_USERS_NUM=User.all.count
      click_link '設定'
      unsubscribe = find_link '退会する'
      expect(unsubscribe['data-confirm']).to eq '本当に退会しますか'
      page.accept_confirm '本当に退会しますか' do
        click_link '退会する'
      end
      expect(current_path).to eq root_path
      expect(User.all.count).to eq INITIAL_USERS_NUM-1
    end
  end
end