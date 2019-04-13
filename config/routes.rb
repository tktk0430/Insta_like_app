Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
  get 'policy', to: 'home#policy'

  resources :users do
    member do
      get :following, :followers, :like_posts, :microposts
    end
    get :search, on: :collection
  end
  get :signup, to: 'users#new'
  resource :password, only: [:edit,:update]

  resources :sessions, only: [:new,:create, :destroy]
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'

  resources :searches, only: [:index,:new,:show]
  resources :microposts, only: [:index,:show,:new,:create,:destroy]
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :testusers, only: :create
  resources :testsessions, only: :create
end
