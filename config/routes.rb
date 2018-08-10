Rails.application.routes.draw do
  resources :servers do
    resources :containers
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'containers/restart/:id', to: 'containers#restart', as: 'restart'

  root 'servers#index'
end
