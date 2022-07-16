Rails.application.routes.draw do


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


    resources :users, only: [:edit, :show, :index,  :update]

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
    get 'homes/about' => 'homes#about',as: 'about'

    resources :users, only: [:edit, :index, :show ]

    resources :posts, only: [:show, :destroy, :index]


  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
