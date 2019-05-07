require 'rails_helper'

RSpec.describe "Search", type: :system do
  let(:tom){FactoryBot.create(:user,name:'tom')}
  let(:bob){FactoryBot.create(:user,name:'bob')}
  let(:post_to_be_searched1){FactoryBot.create(:micropost,contributer:bob,content:'山の風景です')}
  let(:post_to_be_searched2){FactoryBot.create(:micropost,contributer:tom,content:'川の風景も好きです')}
  let(:post_not_to_be_searched){FactoryBot.create(:micropost,contributer:tom,content:'これはけんさくしてほしくないですね')}

  before do
    login(tom)
    post_to_be_searched1
    post_to_be_searched2
    post_not_to_be_searched
  end

  scenario '検索ワードと同じ本文を持つ画像が表示される' do
    click_link '検索'
    fill_in 'query', with:'風景'
    click_button '検索'
    expect(page.body).to have_content "'風景'の検索結果"
    expect(page).to have_link href: micropost_path(post_to_be_searched1)
    expect(page).to have_link href: micropost_path(post_to_be_searched2)
    expect(page).not_to have_link href: micropost_path(post_not_to_be_searched)
  end
end