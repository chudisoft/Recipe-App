class FoodsController < ApplicationController
  before_action :authenticate_user! # Ensure user authentication before accessing foods

  def index
    @foods = current_user.foods # Retrieve foods of the logged-in user
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params) # Create new food for the current user
    if @food.save
      redirect_to foods_path, notice: 'Food added successfully.'
    else
      render 'new'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food was successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
