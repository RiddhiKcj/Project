Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations", confirmations: "users/confirmations" }

  namespace :api, :defaults => { :format => 'json' } do
    resources :weather, only: :index
    resources :news, only: :index
  end
  resources :users,  only: :index do
  	resources :myapis, only: [:new, :create, :destroy]
  end

  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
  get '/admin', to: 'admin#index'
    match "/admin/*path", to: "admin#index", format: false, via: :get
end
