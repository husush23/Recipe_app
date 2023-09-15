require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Recipes', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'lumbuye', email: 'text@t.com', password: '123456')
    @user.confirm
    sign_in @user
  end

  describe 'GET /recipes' do
    before do
      get '/recipes'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /recipes/new' do
    before do
      Recipe.create(user: @user, name: 'test', preparation_time: 1, cooking_time: 1,
                    description: 'This description', public: true)
      get '/recipes/new'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns placeholder from the body' do
      expect(response.body).to include('Create Recipe')
    end
  end

  describe 'GET /recipes/:id' do
    it 'responds with success' do
      recipe = Recipe.create(user: @user, name: 'test', preparation_time: 1, cooking_time: 1,
                             description: 'This description', public: true)
      get "/recipes/#{recipe.id}"
      expect(response).to have_http_status(:success)
    end

    it 'includes recipe name in the response body' do
      recipe = Recipe.create(user: @user, name: 'test', preparation_time: 1, cooking_time: 1,
                             description: 'This description', public: true)
      get "/recipes/#{recipe.id}"
      expect(response).to have_http_status(:success)
      expect(response.body).to include('test')
    end
  end
end
