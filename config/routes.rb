Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'liked_reviews/index'
      get 'my_reviews/index'
      get 'registered_shops/index'
      resources :users, only: [:index, :create]
      resources :users, param: :sub, only: [:update]
      resources :shops, only: [:index, :create, :show, :update, :destroy] do
        collection do
          get 'search'
        end
        resources :reviews, only: [:index, :create, :show, :update, :destroy] do
          resources :likes, only: [:index, :create, :destroy]
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
