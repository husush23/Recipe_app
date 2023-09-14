class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
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

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(updated_recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe public status updated successfuly'
    else
      redirect_to recipe_path(@recipe), notice: 'Recipe could not be upddated'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe successfully created'
    else
      flash.now[:error] = "Couldn't delete the recipe"
    end
  end

  private

  def new_recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end

  def updated_recipe_params
    params.require(:recipe).permit(:public)
  end
end
