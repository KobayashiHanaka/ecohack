Rails.application.routes.draw do

  devise_for :admins
  scope module: :public do

    resources :users, only: [:index, :show, :edit]

    devise_for :users

    root to: 'homes#top'
    get 'homes/about' => 'homes#about',as: 'about'

    resources :posts, only: [:index, :show, :edit,:create,:destroy,:update]

  end

  namespace :admin do

    root to: 'homes#top'
    get 'homes/about' => 'homes#about',as: 'about'

    resources :users, only: [:index, :show, :edit]

    resources :posts, only: [:index, :show,:destroy]


  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
