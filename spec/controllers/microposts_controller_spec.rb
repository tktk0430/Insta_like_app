require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  before do
    @user=FactoryBot.create(:user)
  end

  describe '#index' do
    it 'ログインしていれば#newにリダイレクトされる' do
      login(@user)
      get :index
      expect(response).to have_http_status '302'
    end

    it 'ログインしてなければloginページにリダイレクトされる' do
      get :index
      expect(response).to have_http_status '302'
    end
  end
end
