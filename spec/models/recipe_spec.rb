require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'test_user') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      recipe = Recipe.new(
        name: 'Test Recipe',
        description: 'A test recipe',
        preparation_time: 30,
        cooking_time: 45,
        user:
      )
      expect(recipe).to be_valid
    end
    it 'is not valid without a name' do
      recipe = Recipe.new(
        description: 'A test recipe',
        preparation_time: 30,
        cooking_time: 45,
        user:
      )
      expect(recipe).not_to be_valid
    end


    it 'is not valid without a description' do
      recipe = Recipe.new(
        name: 'Test Recipe',
        preparation_time: 30,
        cooking_time: 45,
        user:
      )
      expect(recipe).not_to be_valid
    end

    it 'is not valid with a negative preparation_time' do
      recipe = Recipe.new(
        name: 'Test Recipe',
        description: 'A test recipe',
        preparation_time: -10,
        cooking_time: 45,
        user:
      )
      expect(recipe).not_to be_valid
    end

    it 'is not valid with a negative cooking_time' do
      recipe = Recipe.new(
        name: 'Test Recipe',
        description: 'A test recipe',
        preparation_time: 30,
        cooking_time: -10,
        user:
      )
      expect(recipe).not_to be_valid
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

    it 'has many foods through recipe_foods' do
      association = described_class.reflect_on_association(:foods)
      expect(association.macro).to eq(:has_many)
    end
  end
end
