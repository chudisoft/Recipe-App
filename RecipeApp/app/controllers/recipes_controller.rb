class RecipesController < ApplicationController
  before_action :authenticate_user! # Ensure user authentication before accessing recipes

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params) # Assign current user's ID to the recipe

    # @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render 'new'
    end
  end

  def index
    @recipes = current_user.recipes # Retrieve recipes of the logged-in user
  end

  def show
    @recipe = Recipe.find(params[:id]) # Find the recipe by ID
    # @recipe = Recipe.includes(:foods).find(params[:id])
    # Check if the user is the owner of the recipe
    if current_user == @recipe.user || @recipe.public?
      # Display the recipe details and allow editing if the user is the owner
      # @foods = @recipe.foods # Assuming association between Recipe and Food
      @recipe_foods = @recipe.recipe_foods.includes(:food)
    else
      redirect_to recipes_path, alert: "You don't have access to view this recipe."
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.update(public: !@recipe.public)
      redirect_to @recipe, notice: 'Recipe visibility toggled.'
    else
      redirect_to @recipe, alert: 'You are not authorized to perform this action.'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user # Ensure the current user owns the recipe
      @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe was successfully removed.'
    else
      redirect_to recipes_path, alert: "You don't have permission to remove this recipe."
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
