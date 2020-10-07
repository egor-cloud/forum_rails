Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
        # to: redirect("main#index")

  root to: "main#index"

  get 'rules/index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :tags, only: [:show]
  resources :comments, only: [:create, :destroy]

  resources :users, except: [:index, :destroy]

  resources :categories, only: [:index, :show] do
    resources :posts, only: [:new, :create, :show, :edit, :update] do
      member do
        put "like" => "posts#upvote"
        put "deslike" => "posts#downvote"
        put "like_answer" => "answers#upvote"
        put "deslike_answer" => "answers#downvote"
      end
      resources :answers, only: [:new, :create, :destroy] do
      end
    end
  end

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :categories, except: [:index, :show]
    get '/categories_admin' => 'categories#index'
  end
end


