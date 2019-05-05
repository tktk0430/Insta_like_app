require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like){FactoryBot.create(:like)}

  it 'のFactoryBotは正常に動く' do
    expect(like).to be_valid
  end

  it 'はuserがないと無効' do
    like.user=nil
    expect(like).not_to be_valid
  end

  it 'はmicropostがないと無効' do
    like.micropost=nil
    expect(like).not_to be_valid
  end
end
