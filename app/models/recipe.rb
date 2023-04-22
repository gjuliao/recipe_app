class Recipe < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 150 }
  validates :preparation_time, presence: true, numericality: true
  validates :cooking_time, presence: true, numericality: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true

  def total_cost
    @current_recipe_food = RecipeFood.where(recipe: id)
    cost = 0
    @current_recipe_food.each do |food|
      cost += Food.find(food.food_id).price
    end
    cost
  end
end
