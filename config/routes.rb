Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :courses
  resources :transactions
  resources :payments, only: [:new, :create]

end
