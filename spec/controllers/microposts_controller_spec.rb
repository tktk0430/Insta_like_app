require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  before do
    @user=FactoryBot.create(:user)
    @another=FactoryBot.create(:user)
    @micropost=FactoryBot.create(:micropost,contributer:@user)
  end

  describe '#index' do
    context 'ログインユーザーの場合'do
      before do
        login(@user)
      end

      it '新規投稿にリダイレクトされる' do
        get :index
        expect(response).to redirect_to '/microposts/new'
      end
    end

    context 'ログインユーザーではない場合' do
      it 'ログインページにリダイレクトされる' do
        get :index
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#show' do
    context 'ログインユーザーの場合'do
      before do
        login(@user)
      end

      it '新規投稿にリダイレクトされる' do
        get :index
        expect(response).to redirect_to '/microposts/new'
      end
    end

    context 'ログインユーザーではない場合' do
      it 'ログインページにリダイレクトされる' do
        get :index
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#create' do
    context 'ログインユーザーの場合は'do
      before do
        login(@user)
        @micropost_params=FactoryBot.attributes_for(:micropost)
      end

      it '正しく投稿ができる' do
        expect {
          post :create, params: {micropost: @micropost_params}
        }.to change(@user.microposts, :count).by(1)
      end

      it '画像がないと投稿できない' do
        @micropost_params[:image_data]=nil
        expect{
          post :create, params: {micropost: @micropost_params}
        }.not_to change(@user.microposts,:count)
      end

      it '本文はなくても投稿できる' do
        @micropost_params[:content]=nil
        expect{
          post :create, params: {micropost: @micropost_params}
        }.to change(@user.microposts,:count).by(1)
      end
    end

    context 'ログインユーザーではない場合' do
      it 'ログインページにリダイレクトされる' do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#destroy' do
    context '投稿者の場合'do
      before do
        login(@user)
      end

      it '正しく削除ができる' do
        expect {delete :destroy, params:{id:@micropost.id}}.to change(@user.microposts, :count).by(-1)
      end
    end

    context '投稿者ではない場合' do
      before do
        login(@another)
      end

      it '投稿を削除できない' do
        expect {delete :destroy, params:{id:@micropost.id}}.not_to change(@user.microposts, :count)
      end

      it '削除しようとしたらrootにリダイレクトされる' do
        delete :destroy, params:{id:@micropost.id}
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインユーザーではない場合' do
      it '削除しようとしたらloginにリダイレクトされる' do
        delete :destroy, params:{id:@micropost.id}
        expect(response).to redirect_to login_path
      end
    end
  end
end
