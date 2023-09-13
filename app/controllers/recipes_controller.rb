class RecipesController < ApplicationController
    def index
        @recipes = Recipe.where(user_id: current_user.id)
    end

    def new
        @recipe = Recipe.new
        @user = current_user
    end

    def create
        @user = current_user
        @recipe = @user.recipes.build(new_recipe_params)

        if @recipe.save
        redirect_to recipes_path, notice: 'Recipe successfully created'
        else
        flash.now[:error] = @recipe.errors.full_messages.to_sentence
        render :new
        end
    end

    private

    def new_recipe_params
        params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
    end
end