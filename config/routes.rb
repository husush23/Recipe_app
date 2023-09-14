Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'

  get 'shopping_list', to: 'shopping_list#index', as: 'shopping_list'

  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :new, :create, :destroy, :show] do
      resources :recipe_foods, only: [ :new, :create, :destroy]
  end
end
