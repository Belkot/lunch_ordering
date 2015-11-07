Rails.application.routes.draw do
  get 'user/index'

  get 'dashboard/index'

  devise_for :users

  root 'dashboard#index'

  resources :course_types, except: [:show, :destroy]
  resources :courses

end
