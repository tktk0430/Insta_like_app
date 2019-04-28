require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    it 'topページが表示される' do
      get :top
      expect(response).to be_successful
    end
  end

  describe '#about' do
    it 'aboutページが表示される' do
      get :about
      expect(response).to be_successful
    end
  end
end
