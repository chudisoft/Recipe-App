class RecipesController < ApplicationController
  before_action :authenticate_user! # Ensure user authentication before accessing recipes

  def index
    @recipes = current_user.recipes # Retrieve recipes of the logged-in user
  end

  def show
    @recipe = Recipe.find(params[:id]) # Find the recipe by ID
    # Check if the user is the owner of the recipe
    if current_user == @recipe.user || @recipe.public?
      # Display the recipe details and allow editing if the user is the owner
      @foods = @recipe.foods # Assuming association between Recipe and Food
    else
      redirect_to recipes_path, alert: "You don't have access to view this recipe."
    end
  end
end
