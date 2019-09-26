Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations", confirmations: "users/confirmations" }
  get 'welcome/index'
  #root 'articles#index'
  # root 'api/welcome#index', :defaults => { :format => 'json' }

  namespace :api, :defaults => { :format => 'json' } do
    resources :weather, only: :index
    resources :news, only: :index
  end
  resources :users,  only: :index do
  	resources :myapis, only: [:new, :create, :destroy]
  end
  # get 'news/index'
  # get 'weather/index'

  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
  
end
