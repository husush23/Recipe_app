require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a valid name' do
      user = User.new(name: 'John Doe')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new
      expect(user).not_to be_valid
    end

    it 'is not valid with a name exceeding the maximum length' do
      user = User.new(name: 'A' * 251)
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many recipes' do
      association = described_class.reflect_on_association(:recipes)
      expect(association.macro).to eq(:has_many)
    end

    it 'destroys associated recipes when destroyed' do
      user = User.create(name: 'John Doe')
      recipe = user.recipes.create(name: 'Test Recipe', description: 'A test recipe', preparation_time: 30, cooking_time: 45)
      expect { user.destroy }.to change { Recipe.count }.by(-1)
    end

    it 'has many foods' do
      association = described_class.reflect_on_association(:foods)
      expect(association.macro).to eq(:has_many)
    end

    it 'destroys associated foods when destroyed' do
      user = User.create(name: 'John Doe')
      food = user.foods.create(name: 'Test Food', measurement_unit: 'g', quantity: 100, price: 5)
      expect { user.destroy }.to change { Food.count }.by(-1)
    end
  end
end
