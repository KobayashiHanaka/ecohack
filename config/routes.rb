Rails.application.routes.draw do

  
  scope module: :public do
    
    devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
    }
    resources :users, only: [:index, :show, :edit]

    root to: 'homes#top'
    get 'homes/about' => 'homes#about',as: 'about'

    resources :posts, only: [:index, :show, :edit,:create,:destroy,:update]

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
end
