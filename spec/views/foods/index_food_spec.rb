require 'rails_helper'
require_relative 'actions_helper_food'

RSpec.describe 'food/index.html.erb', type: :system do
  include ActionsHelperFood
  User.delete_all
  Recipe.delete_all
  Food.delete_all
  RecipeFood.delete_all

  let(:user) { User.create(name: 'John', email: 'John@gmail.com', password: '123456') }

  let(:recipe) do
    Recipe.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60,
                  description: 'Recipe description', public: true, user: user)
  end

  let(:food) { Food.create(name: 'Eggs', user: user, quantity: 2, measurement_unit: 'grams', price: 10) }

  it 'displays the list of foods' do
    sign_in
    visit user_foods_path(user)
    RecipeFood.where(recipe_id: food.id).each do |food|
      expect(page).to have_content(food.food.name)
      expect(page).to have_content(food.quantity)
      expect(page).to have_content(food.food.price)
    end
  end
end
