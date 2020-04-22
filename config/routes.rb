Rails.application.routes.draw do
  root to: 'home#index'

  resources :articles
  resources :categories

  namespace :api do
    resources :articles

    resources :category do 
      collection do
        scope module: :category do 
          resources :filters, only: [:index]
        end
      end 
    end
  end
end
