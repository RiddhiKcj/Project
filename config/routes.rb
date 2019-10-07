Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api, :defaults => { :format => 'json' } do
    resources :users, only: :update
    get '/home', to: "welcome#index", defaults: { format: 'json' }

    namespace :widgets do
      resources :weather, only: :index
      resources :news, only: :index
      resources :currencyexc, only: :index
    end

    resources :users do
      resources :selectedwidgets, only: [:create]
    end

  end
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy

  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
  get '/admin', to: 'admin#index'
  match "/admin/*path", to: "admin#index", format: false, via: :get
  
end
