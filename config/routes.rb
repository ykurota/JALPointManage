Rails.application.routes.draw do
  devise_for :users
  resources :campaigns
  resources :flightclasses
  resources :cities
  get 'jalpoint', to: 'jalpoint#index'
  post 'jalpoint', to: 'jalpoint#index'
  get 'jalpoint/index'
  post 'jalpoint/index'
  get 'jalpoint/edit/:id', to: 'jalpoint#edit'
  post 'jalpoint/edit/:id', to: 'jalpoint#update'
  patch 'jalpoint/edit/:id', to: 'jalpoint#update'
  get 'jalpoint/delete/:id', to: 'jalpoint#delete'
  get "jalpoint/calpoint"
  get 'jalpoint', to: 'jalpoint#calpoint'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
