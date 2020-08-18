# frozen_string_literal: true

Rails.application.routes.draw do

  resources :articles do
    scope module: :articles do
      resources :images
    end
  end

  resources :categories

  get 'login', to: 'sessions#new'

  resource :session

  namespace :article_view_counters do
    resources :articles
  end
  resources :article_view_counters

  namespace :api do
    resources :charts

    resources :articles do
      scope module: :articles do
      end

      collection do
        scope module: :articles do
        end
      end
    end

    resources :article_methods, only: [] do
      scope module: :article_methods do
        resources :with_counters, only: [:index]
        resources :searches, only: [:index]
        resources :charts, only: [:index]
      end
    end

    resources :category do
      collection do
        scope module: :category do
          resources :filters, only: [:index]
        end
      end
    end
  end

  root to: 'home#index'

end
