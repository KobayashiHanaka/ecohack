Rails.application.routes.draw do


  get 'relationships/followings'
  get 'relationships/followers'
  scope module: :public do

    devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
    }


    #devise_scope :users do
      #get '/users', to: redirect("users/sign_up")
    #end
    #ルーティングが被ってしまったので一旦保留


    resources :users, only: [:index, :show, :edit,:update] do
      resource :relationships, only: [:create, :destroy]
      #(使用検討中) get 'followinds' => 'relationships#followings', as: 'followings'
      #(使用検討中) get 'followers' => ' relationships#followers', as: 'followers'
    end

    root to: 'homes#top'
    get 'homes/about' => 'homes#about',as: 'about'

    resources :posts, only: [:index, :show, :edit,:create,:destroy,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end


  end

  namespace :admin do

    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
    }

    root to: 'homes#top'
    get 'homes/about' => 'homes#about',as: 'about'

    resources :users, only: [:index, :show, :edit]

    resources :posts, only: [:index, :show,:destroy]


  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    get 'search' => "searches#search"
end
