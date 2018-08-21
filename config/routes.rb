Rails.application.routes.draw do
  # get 'users', to: 'containers#index', as: 'users'
  # get 'users', to: 'containers#index', as: 'users'
  resources :servers do
    resources :containers
  end
  devise_for :users, skip: [:sessions]
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    match 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :edit, :update] 

  get 'containers/restart/:id', to: 'containers#restart', as: 'restart'
  post 'containers/:id', to: 'containers#show', as: 'size_log'

  root 'servers#index'
end
