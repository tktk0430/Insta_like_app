require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:tom){FactoryBot.create(:user,name:'tom')}

  it 'paramsでの編集も有効' do
    login(tom)
    patch :update, params:{id:tom.id, user:{name:'super_neo_tom'}}
    expect(tom.reload.name).to eq 'super_neo_tom'
  end
end
