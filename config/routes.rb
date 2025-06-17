Rails.application.routes.draw do
  resources :users, only: [ :index, :show, :create, :update, :destroy ]
  resources :events, only: [ :index, :show, :create, :update, :destroy ]
  root "static_pages#home"
end
