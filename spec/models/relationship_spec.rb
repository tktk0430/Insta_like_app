require 'rails_helper'

RSpec.describe Relationship, type: :model do
  FactoryBot.use_parent_strategy = false
  let(:rel){FactoryBot.create(:relationship)}

  it 'のFactoryBotは正常に動く' do
    expect(rel).to be_valid
  end

  it 'はid降順に並ぶ' do
    rel1=FactoryBot.create(:relationship)
    rel2=FactoryBot.create(:relationship)
    rel3=FactoryBot.create(:relationship)
    expect(Relationship.first).to eq rel3
  end

  it 'はfollowerがないと無効' do
    rel.follower=nil
    expect(rel).not_to be_valid
  end

  it 'はfollowedがないと無効' do
    rel.followed=nil
    expect(rel).not_to be_valid
  end

  it 'はfollowerとfollowedが同じだと無効（自信をフォローできない)' do
    rel.followed=rel.follower
    expect(rel).not_to be_valid
  end

  it 'は同じfollowerとfollowedの組み合わせは無効' do
    same_rel=rel.dup
    expect(same_rel).not_to be_valid
  end
end
