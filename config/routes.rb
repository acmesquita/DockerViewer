Rails.application.routes.draw do
  devise_for :users
  resources :containers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'containers/restart/:id', to: 'containers#restart', as: 'restart'

  root 'containers#index'
end
