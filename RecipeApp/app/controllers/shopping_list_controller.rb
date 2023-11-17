class ShoppingListController < ApplicationController
  def index
    @foods = current_user.foods.all.select { |food| food.food_remnant < 0 }
  end
end
