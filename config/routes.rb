Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "home/about"=>"homes#about"

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  namespace :user do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :create, :new, :edit, :update, :destroy] do
      resources :post_comments, only: [:new, :create, :destroy]
    end
  end

end
