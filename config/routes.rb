Rails.application.routes.draw do


    #ゲストログインのルーティング
    devise_scope :user do
      post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    end

  # get 'relationships/followings'
  # get 'relationships/followers'

  scope module: :public do

    root to: 'homes#top'
    get 'homes/about' => 'homes#about',as: 'about'

    devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
    }


    #devise_scope :users do
      #get '/users', to: redirect("users/sign_up")
    #end
    #ルーティングが被ってしまったので一旦保留



    resources :users, only: [:edit, :show, :index, :update] do
      get 'favorites' => 'users#favorites'
      resource :relationships, only: [:create, :destroy]
      get 'followinds' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :posts, only: [:edit, :show, :index, :create,:destroy,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end

  namespace :admin do

    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
    }

    root to: 'homes#top'

    resources :users, only: [:index, :show, :destroy]


    resources :posts, only: [:show, :destroy, :index]


  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    get 'search' => "searches#search"
end
