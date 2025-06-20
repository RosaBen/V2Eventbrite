Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :events do
    resources :attendances
  end
  post "checkout", to: "checkout#create"
  get 'payments/success', to: 'payments#success', as: 'payment_success'

  root "static_pages#home"
end
