Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'

  get 'general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'

  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :new, :create, :destroy, :show, :update] do
      resources :recipe_foods, only: [ :new, :create, :destroy]
  end
  get 'public_recipes', to: 'public_recipes#index', as: 'public_recipes'
end
