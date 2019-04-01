Rails.application.routes.draw do
  resources :users
  root 'home#top'
  get 'about', to: 'home#about'
  get 'signup', to: 'users#new'
end
