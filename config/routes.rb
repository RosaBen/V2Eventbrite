Rails.application.routes.draw do
  resources :users
  resources :events
  get "/signup", to: "users#new", as: "signup"
  get "/login", to: "sessions#new", as: "login"
  post "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
  root "static_pages#home"
end
