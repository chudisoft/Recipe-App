class RecipeFoodsController < ApplicationController
  before_action :set_recipe
  before_action :set_recipe_food, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build
    @foods = Food.all # Fetch all available foods
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    if @recipe_food.save
      redirect_to @recipe, notice: 'Food added to recipe successfully.'
    else
      @foods = Food.all
      render 'new'
    end
  end

  def edit
    @foods = Food.all # Fetch all available foods
  end

  def update
    if @recipe_food.update(recipe_food_params)
      redirect_to @recipe, notice: 'Recipe food was successfully updated.'
    else
      @foods = Food.all
      render 'edit'
    end
  end

  # def destroy
  #   @recipe_food.destroy
  #   redirect_to @recipe, notice: 'Recipe food was successfully removed.'
  # end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(params[:recipe_id]), notice: 'Recipe food was successfully deleted.'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_recipe_food
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
