# frozen_string_literal: true

Rails.application.routes.draw do

  # 管理画面
  namespace :admin do
    root to: 'home#index'

    resources :qiita_syncs, only: [:index] do
      collection do
        get :sycn_items
      end
    end

    namespace :articles do
      resources :leave_forms
      resources :filtered_articles
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

  # 表画面
  root to: 'guest/home#index'

  namespace :guest do
    resources :articles do
      collection do
        scope module: :articles do
          resources :categorized_articles, only: [:index]
          resources :filtered_articles, only: [:index]
        end
      end
    end
  end

end
