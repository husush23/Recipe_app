Rails.application.routes.draw do
  devise_for :users
  root 'recipes#public_recipes' as :public_recipes

  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :new, :create, :destroy] do
      resources :recipe_foods, only: [ :new, :create]
  end
end
