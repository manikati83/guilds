Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'toppages#index'
  get 'home', to: 'toppages#home'
  get 'timeline', to: 'timelines#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :favorite_guilds
      get :join_guilds
      get :approval_guilds
      get :questing
      get :quested
      get :offer_questing
      get :offer_quested
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
      get :gallery
      get :quest
      get :questing
      get :quested
    end
  end
  
  resources :guild_members
  resources :guild_news, only: [:create, :destroy]
  resources :blogs
  resources :approvals
  resources :messages
  resources :quests do
    member do
      get :member_chat
    end
  end
  resources :quest_members, only: [:create, :destroy]
  resources :quest_messages, only: [:create, :destroy]
  resources :favorite_guilds, only: [:create, :destroy]
  resources :favorite_blogs, only: [:create, :destroy]
  resources :favorite_galleries, only: [:create, :destroy]
  resources :galleries, only: [:new, :show, :create, :destroy]
end
