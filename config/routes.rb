Rails.application.routes.draw do
  root to: 'home#index'

  resources :articles
  resources :categories

  namespace :api do
    resources :articles
  end
end
