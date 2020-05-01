# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :articles
  resources :categories
  resource :session

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
end
