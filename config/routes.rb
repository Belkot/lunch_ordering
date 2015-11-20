Rails.application.routes.draw do
  get 'users', to: 'users#index'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  devise_for :users

  resources :course_types, except: [:show, :destroy]
  resources :courses, except: :show
  resources :orders, only: [:index, :new, :create]
  get 'orders/menu', to: 'orders#menu'
  namespace :api do
    resources :orders, only: :index
  end

  root 'dashboard#index'
end
