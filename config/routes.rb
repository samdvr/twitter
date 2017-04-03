Rails.application.routes.draw do

  devise_for :users
  resources :microtweets, only: [:index]

  root to: "microtweets#index"

end
