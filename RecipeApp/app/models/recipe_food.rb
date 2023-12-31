class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { only_integer: true }, comparison: { greater_than: 0 }
end
