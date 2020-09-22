# frozen_string_literal: true

Rails.application.routes.draw do

  namespace :admin do
    resources :qiita_syncs, only: [:index] do
      collection do
        get :sycn_items
      end
    end

    resources :articles do
      scope module: :articles do
        resources :images
      end

      collection do
        scope module: :articles do
          resource :confirm, only: [] do
            post :new_modal
            post :update_modal
          end
        end
      end
    end

    resources :categories

    get 'login', to: 'sessions#new'

    resource :session

    namespace :article_view_counters do
      resources :articles
    end
    resources :article_view_counters
  end

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
