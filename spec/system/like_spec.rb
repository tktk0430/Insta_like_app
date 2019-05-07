require 'rails_helper'

RSpec.describe "Like", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  let(:bob_post){FactoryBot.create(:micropost,contributer:bob)}

  context 'create(いいね), destroy(いいね解除)' do
    before do
      login(tom)
      bob_post
    end

    scenario 'いいねした後、いいね解除する' do
      visit user_path(bob)
      click_link href: micropost_path(bob_post)
      within '.micropost-show' do
        expect(page).to have_link 'いいね'
        expect{click_link 'いいね'}.to change(tom.like_posts,:count).by(1)
        expect(page).to have_link 'いいね解除'
        expect{click_link 'いいね解除'}.to change(tom.like_posts,:count).by(-1)
        expect(page).to have_link 'いいね'
      end
    end
  end
end