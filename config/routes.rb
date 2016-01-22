Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  post   'like/:micropost_id', to: 'likes#like', as: 'like'
  delete 'unlike/:micropost_id', to: 'likes#unlike', as: 'unlike'
  delete 'logout', to: 'sessions#destroy'
  

  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
