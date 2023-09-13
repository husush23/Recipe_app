Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'

  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :new, :create, :destroy, :show] do
      resources :recipe_foods, only: [ :new, :create, :destroy]
  end
end
