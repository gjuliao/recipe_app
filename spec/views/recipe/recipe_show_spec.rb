require 'rails_helper'
require_relative 'actions_helper_recipe'

RSpec.describe 'recipes/show.html.erb', type: :system do
  include ActionsHelperRecipe
  User.delete_all
  Recipe.delete_all
  Food.delete_all
  RecipeFood.delete_all

  let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }

  let(:recipe) do
    Recipe.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60,
                  description: 'Recipe description', public: true, user:)
  end

  it 'displays the recipe name' do
    sign_up
    visit user_recipe_path(user, recipe)
    expect(page).to have_content(recipe.name)
  end

  it 'displays the recipe description' do
    sign_up
    visit user_recipe_path(user, recipe)
    expect(page).to have_content(recipe.description)
  end

  it 'displays the recipe preparation time' do
    sign_up
    visit user_recipe_path(user, recipe)
    expect(page).to have_content(recipe.preparation_time)
  end

  it 'displays the list of recipe foods' do
    sign_up
    visit user_recipe_path(user, recipe)
    RecipeFood.where(recipe_id: recipe.id).each do |recipe_food|
      expect(page).to have_content(recipe_food.food.name)
      expect(page).to have_content(recipe_food.quantity)
      expect(page).to have_content(recipe_food.food.price)
    end
  end
end
