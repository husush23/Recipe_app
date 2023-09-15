require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

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

    it 'has many foods' do
      association = described_class.reflect_on_association(:foods)
      expect(association.macro).to eq(:has_many)
    end
  end
end
