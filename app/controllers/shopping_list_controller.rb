class ShoppingListController < ApplicationController
  def index
    foods = Food.includes(:recipe_foods).where({ user_id: current_user.id })
    @shopping_list = []
    @total_price = 0
    foods.each do |food|
      shopping_list_item = {
        food: food.name,
        quantity: calculate_missing_food(food),
        unit: food.measurement_unit,
        unit_price: food.price
      }
      @total_price += shopping_list_item[:quantity] * shopping_list_item[:unit_price]
      @shopping_list << shopping_list_item if (shopping_list_item[:quantity]).positive?
    end
  end

  private

  def calculate_missing_food(food)
    missing_food = -food.quantity
    food.recipe_foods.each do |recipe_food|
      missing_food += recipe_food.quantity
    end

    return 0 if missing_food <= 0

    missing_food
  end
end
