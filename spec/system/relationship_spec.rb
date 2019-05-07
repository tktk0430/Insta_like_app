require 'rails_helper'

RSpec.describe "Relationship", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  let(:alice){FactoryBot.create(:user,name:'alice')}

  context 'create(フォロー)' do
    before do
      login(tom)
      tom.follow(alice)
    end

    scenario 'フォローする' do
      visit user_path(bob)
      within "#follow-button" do
        expect(page).to have_link 'フォロー'
        expect{click_link 'フォロー'}.to change(tom.following,:count).by(1)
        expect(page).to have_link 'フォロー解除'
      end
    end
  end

  context 'destroy(フォロー解除)', type: :system do
    before do
      login(tom)
      tom.follow(alice)
    end

    scenario 'フォロー解除する' do
      visit user_path(alice)
      within "#follow-button" do
        expect(page).to have_link 'フォロー解除'
        expect{click_link 'フォロー解除'}.to change(tom.following,:count).by(-1)
        expect(page).to have_link 'フォロー'
      end
    end
  end
end