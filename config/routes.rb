# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :articles
  resources :categories

  namespace :api do
    resources :articles do
      collection do
        scope module: :articles do
        end
      end
    end

    resources :article_methods, only: [] do
      collection do
        scope module: :article_methods do
          resources :with_counters, only: [:index]
          resources :searches, only: [:index]
        end
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
