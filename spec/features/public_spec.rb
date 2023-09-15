require 'rails_helper'

RSpec.feature 'Public Recipes', type: :feature do
  before :each do
    # Create a user and confirm it
    user = User.create(name: 'John', email: 'john@example.com', password: 'password')
    user.confirm # Confirm the user

    # Visit the sign-in page and log in
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    # Visit the root path once before each example
    visit root_path
  end

  describe 'User views public recipes' do
    it 'should have shopping list link' do
      expect(page).to have_content('Shopping list')
    end

    it 'should have food link' do
      expect(page).to have_content('Foods')
    end

    it 'should have recipe link' do
      expect(page).to have_content('Recipe')
    end

    it 'should have logo' do
      expect(page).to have_content('Recipe App')
    end
    it 'should have add buttom' do
      expect(page).to have_content('Add a recipe')
    end
  end
end
