require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'test_user') }
  let(:food) { Food.create(name: 'Test Food', measurement_unit: 'g', user:, quantity: 100, price: 5) }
  let(:recipe) do
    Recipe.create(name: 'Test Recipe', description: 'A test recipe', preparation_time: 30, cooking_time: 45, user:)
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      recipe_food = RecipeFood.new(
        food:,
        recipe:,
        quantity: 2
      )
      expect(recipe_food).to be_valid
    end


    it 'is not valid without a quantity' do
      recipe_food = RecipeFood.new(
        food:,
        recipe:
      )
      expect(recipe_food).not_to be_valid
    end

    it 'is not valid with a negative quantity' do
      recipe_food = RecipeFood.new(
        food:,
        recipe:,
        quantity: -1
      )
      expect(recipe_food).not_to be_valid
    end

    it 'is not valid without a food' do
      recipe_food = RecipeFood.new(
        recipe:,
        quantity: 2
      )
      expect(recipe_food).not_to be_valid
    end

    it 'is not valid without a recipe' do
      recipe_food = RecipeFood.new(
        food:,
        quantity: 2
      )
      expect(recipe_food).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
