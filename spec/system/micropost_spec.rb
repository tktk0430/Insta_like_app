require 'rails_helper'

RSpec.describe "Micropost", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  before do
    driven_by :selenium_chrome_headless
  end
  
  context 'new(新規投稿)' do
    scenario '成功',js: true do
      skip 'Too slow test'
      visit root_path
    end
  end
end