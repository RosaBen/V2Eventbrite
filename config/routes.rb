Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :events do
    resources :attendances
    member do
      get :guests
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  post "checkout", to: "checkout#create"
  get "payments/success", to: "payments#success", as: "payment_success"

  root "static_pages#home"
end
