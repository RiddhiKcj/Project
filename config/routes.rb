Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/signup', to: "signup#new"
  devise_for :users, only: [:sessions]

  namespace :api, :defaults => { :format => 'json' } do
    resources :weather, only: :index
    resources :news, only: :index
    resources :currencyexc, only: :index
  end
  resources :users, only: [:create, :update, :destroy]
  resources :users,  only: :index do
    resources :myapis, only: [:index, :new, :create, :destroy]
  end
  get '/api/welcome', to: "welcome#index", defaults: { format: 'json' }
  
  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
  get '/admin', to: 'admin#index'
  match "/admin/*path", to: "admin#index", format: false, via: :get
  
end
