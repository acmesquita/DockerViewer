Rails.application.routes.draw do
  resources :containers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "containers#index"
end
