class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def show; end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      flash.now[:alert] = 'Failed to create a food item. Please check the form for errors.'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food was successfully deleted.'
    else
      redirect_to foods_path, alert: 'Failed to delete the food item.'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
