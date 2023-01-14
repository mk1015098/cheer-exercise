Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "devise/registrations",
    sessions: 'devise/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "home/about"=>"homes#about"

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  namespace :user do
    get "search" => "searches#search"
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :create, :new, :edit, :update, :destroy] do
      resources :post_comments, only: [:new, :create, :destroy]
      resource :favorites, only: [:create, :destroy]
      member do
        get :favorites
      end
    end
  end

  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

end
