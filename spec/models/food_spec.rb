require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      food = Food.new(
        name: 'Test Food',
        measurement_unit: 'g',
        user:,
        quantity: 100,
        price: 5
      )
      expect(food).to be_valid
    end

    it 'is not valid without a name' do
      food = Food.new(
        measurement_unit: 'g',
        user:,
        quantity: 100,
        price: 5
      )
      expect(food).not_to be_valid
    end

    it 'is not valid without a measurement_unit' do
      food = Food.new(
        name: 'Test Food',
        user:,
        quantity: 100,
        price: 5
      )
      expect(food).not_to be_valid
    end

    it 'is not valid without a user_id' do
      food = Food.new(
        name: 'Test Food',
        measurement_unit: 'g',
        quantity: 100,
        price: 5
      )
      expect(food).not_to be_valid
    end

    it 'is not valid without a quantity' do
      food = Food.new(
        name: 'Test Food',
        measurement_unit: 'g',
        user:,
        price: 5
      )
      expect(food).not_to be_valid
    end

    it 'is not valid without a price' do
      food = Food.new(
        name: 'Test Food',
        measurement_unit: 'g',
        user:,
        quantity: 100
      )
      expect(food).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many recipe_foods' do
      association = described_class.reflect_on_association(:recipe_foods)
      expect(association.macro).to eq(:has_many)
    end

    it 'destroys associated recipe_foods when destroyed' do
      food = Food.create(
        name: 'Test Food',
        measurement_unit: 'g',
        user:,
        quantity: 100,
        price: 5
      )
      recipe = Recipe.create(
        name: 'Test Recipe',
        description: 'A test recipe',
        preparation_time: 30,
        cooking_time: 45,
        user:
      )
      RecipeFood.create(food:, recipe:, quantity: 2)
      expect { food.destroy }.to change { RecipeFood.count }.by(-1)
    end
  end
end
