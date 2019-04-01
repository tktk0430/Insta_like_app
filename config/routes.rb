Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
end
