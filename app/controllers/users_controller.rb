class UsersController < ApplicationController

  before_action :set_default_name, only:[:create]
  before_action :login_user?, only:[:index,:show,:edit,:update,:destroy]
  before_action :correct_user?, only:[:edit,:update,:destroy]

  def index
    @users=User.page(params[:page]).per(10)
    @user=current_user
    @page_title="ユーザ一覧"
  end

  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.page(params[:page])
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    @user.image=File.open("#{Rails.root}/db/thumb_image_seeds/default.jpg")
    if @user.save
      login(@user)
      flash[:success]="ようこそ！"
      redirect_to @user
    else
      render 'users/new'
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを編集しました"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def destroy
    user=User.find(params[:id])
    user.destroy
    flash[:info] = "退会しました"
    redirect_to root_path
  end

  def following
    
    @user=User.find(params[:id])

    @users=@user.following.page(params[:page]).per(10)
    
    @page_title="#{@user.name}のフォロー"
    render 'users/index'
  end

  def followers
    @user=User.find(params[:id])
    @users=@user.followers.page(params[:page]).per(10)
    @page_title="#{@user.name}のフォロワー"
    render 'users/index'
  end

  def microposts
    @user=User.find(params[:id])
    @microposts=@user.microposts.page(params[:page]).per(12)
    @page_title="#{@user.name}が投稿した画像"
    render 'microposts/index'
  end

  def like_posts
    @user=User.find(params[:id])
    @microposts=@user.like_posts.page(params[:page]).per(12)
    @page_title="#{@user.name}がいいね！した画像"
    render 'microposts/index'
  end

  def search
    @users=User.search()
    redirect_to 'users/index'
  end

  private
    def set_default_name
      params[:user][:name]="名無しさん" if params[:user][:name].nil? || params[:user][:name].empty?
    end

    def user_params
      params.require(:user).permit(
      :name, :email, :account, :sex, :introduction, :web, :tel, :password, :password_confirmation, :image)
    end
end