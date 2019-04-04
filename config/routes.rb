Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'

  resources :users do
    get 'search', on: :collection
  end
  
  get 'signup', to: 'users#new'

  resources :sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resource :password
end
