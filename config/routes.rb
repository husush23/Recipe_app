Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :new, :create, :destroy, :public_recipes]
end
