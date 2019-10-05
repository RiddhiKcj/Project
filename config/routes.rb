Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #devise_for :users, only: [:sessions]

  namespace :api, :defaults => { :format => 'json' } do
    resources :weather, only: :index
    resources :news, only: :index
    resources :currencyexc, only: :index
  end
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy
  
  namespace :users do
    resources :selectedwidgets, only: [:create]
  end

  root :to => "application#index"
  get '/api/welcome', to: "welcome#index", defaults: { format: 'json' }
  
  
  match "*path", to: "application#index", format: false, via: :get
  get '/admin', to: 'admin#index'
  match "/admin/*path", to: "admin#index", format: false, via: :get
  
end
