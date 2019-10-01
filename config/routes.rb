Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, only: [:sessions]
  namespace :api, :defaults => { :format => 'json' } do
    
    namespace :admin do
      as :user do
        delete 'sign_out', to: '/devise/sessions#destroy'
      end
      resources :users, only: [:create, :update, :destroy]
      get '/home', to: "welcome#index"
      namespace :users do
        resources :myapis, only: [:index, :new, :create, :destroy]
      end
      namespace :widgets do
        resources :weather, only: :index
        resources :news, only: :index
        resources :currencyexc, only: :index
      end
    end
    namespace :auth do
      resources :registrations, only: :create
      resources :sessions, only: :create
    end
  end
    

  get '/admin', to: 'admin#index'
  match "/admin/*path", to: "admin#index", format: false, via: :get
  
  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
end
