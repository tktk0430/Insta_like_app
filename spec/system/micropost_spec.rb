require 'rails_helper'

RSpec.describe "Micropost", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  
  context 'new(新規投稿)' do
    scenario '成功' do
      login(tom)
      expect(current_path).to eq user_path(tom)
    end
  end
end