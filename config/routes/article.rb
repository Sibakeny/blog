resources :articles do
  collection do
    scope module: :articles do
      resources :categorized_articles, only: [:index]
      resources :filtered_articles, only: [:index]
    end
  end
end