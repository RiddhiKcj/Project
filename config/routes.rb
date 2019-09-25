Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations", confirmations: "users/confirmations" }
  get 'welcome/index'
  #root 'articles#index'
  root 'welcome#index'
  resources :users,  only: :index do
  	resources :myapis, only: [:new, :create, :destroy]
  end
  get 'news/index'
  get 'weather/index'


end
