require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :feature do
  include Warden::Test::Helpers

  before(:each) do
    User.delete_all
    Recipe.delete_all
    Food.delete_all
    RecipeFood.delete_all

    @user = User.create!(name: 'Victor', email: 'victor@gmail.com', password: '123456')
    login_as(@user, scope: :user)
  end

  let(:recipe) do
    Recipe.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60,
                  description: 'Recipe description', public: true, user: @user)
  end

  it 'displays the recipe name' do
    visit user_recipe_path(@user, recipe)
    expect(page).to have_content(recipe.name)
  end

  it 'displays the recipe description' do
    visit user_recipe_path(@user, recipe)
    expect(page).to have_content(recipe.description)
  end

  it 'displays the recipe preparation time' do
    visit user_recipe_path(@user, recipe)
    expect(page).to have_content(recipe.preparation_time)
  end

  it 'displays the list of recipe foods' do
    visit user_recipe_path(@user, recipe)
    RecipeFood.where(recipe_id: recipe.id).each do |recipe_food|
      expect(page).to have_content(recipe_food.food.name)
      expect(page).to have_content(recipe_food.quantity)
      expect(page).to have_content(recipe_food.food.price)
    end
  end
end
