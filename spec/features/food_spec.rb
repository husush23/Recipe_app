require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  before :each do
    @user = User.create(name: 'User 1', email: 'email@gamil.com', password: '123456')
    @food = Food.create(name: 'Food 1', measurement_unit: 'g', price: '23.1', quantity: 1, user: @user)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/foods'
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_food_path
      expect(response).to have_http_status(302)
    end
  end

  describe ' /destroy' do
    it 'destroys the food' do
      expect do
        delete food_path(@food)
      end.to change(Food, :count).by(0)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe ' /new' do
    it 'returns http success' do
      get new_food_path
      expect(response).to have_http_status(302)
    end
  end
end
