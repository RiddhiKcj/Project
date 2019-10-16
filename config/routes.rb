Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root :to => "application#index"
  namespace :api, :defaults => { :format => 'json' } do
    resources :users, only: :update
    get '/home', to: "welcome#index", defaults: { format: 'json' }

    namespace :widgets do
      resources :weather, only: [:index, :create]
      resources :news, only: :index
      resources :currencyexc, only: :index
      resources :movies, only: :index
    end

    resources :users do
      resources :selectedwidgets, only: [:create]
    end

  end
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy

  
  match "*path", to: "application#index", format: false, via: :get
  get '/admin', to: 'admin#index'
  match "/admin/*path", to: "admin#index", format: false, via: :get
  
end
