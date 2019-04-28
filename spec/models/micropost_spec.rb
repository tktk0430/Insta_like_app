require 'rails_helper'

RSpec.describe Micropost, type: :model do
  it "のFactoryBotは正常に動く" do
    post=FactoryBot.build(:micropost)
    expect(FactoryBot.build(:micropost)).to be_valid
  end
end
