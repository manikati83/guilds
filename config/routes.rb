Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]
  
  get 'search', to: 'guilds#search'
  get 'tags', to: 'guilds#tags'
  
  resources :guilds do
    member do
      get :blogs
      get :members
      get :approval_members
    end
  end
  
  resources :guild_members
  resources :blogs
  resources :approvals
  resources :messages
end
