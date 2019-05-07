require 'rails_helper'

RSpec.describe "Micropost", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}

  before do
    skip '非常に時間がかかるため、最終確認時以外はskip'
  end
  
  context 'new(新規投稿):js' do
    scenario '成功',js: true do
      visit root_path
    end
  end
end