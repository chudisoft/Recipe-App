class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  def food_remnant
    quantity - recipe_foods.sum(:quantity)
  end
end
