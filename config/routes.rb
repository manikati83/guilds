Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :favorite_guilds
      get :join_guilds
      get :approval_guilds
    end
  end
  
  get 'search', to: 'guilds#search'
  get 'tags', to: 'guilds#tags'
  
  resources :guilds do
    member do
      get :blogs
      get :members
      get :approval_members
      get :news
    end
  end
  
  resources :guild_members
  resources :blogs
  resources :approvals
  resources :messages
  resources :favorite_guilds, only: [:create, :destroy]
end
