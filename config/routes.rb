Rails.application.routes.draw do
  get 'weather/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations", confirmations: "users/confirmations" }
  get 'welcome/index'
  #root 'articles#index'
  root 'welcome#index'
  resources :users,  only: :index do
  	resources :articles
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
