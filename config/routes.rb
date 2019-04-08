Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'

  resources :users do
    member do
      get :following, :followers
    end
    get 'search', on: :collection
  end
  get 'signup', to: 'users#new'

  resources :sessions, only: [:new,:create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resource :password, only: [:edit,:update]

  resources :microposts

  resources :relationships, only: [:create, :destroy]
end
