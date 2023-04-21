require 'rails_helper'

RSpec.describe 'recipes/public.html.erb', type: :feature do
  User.delete_all
  Recipe.delete_all
  Food.delete_all
  RecipeFood.delete_all

  let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }

  let(:recipe) do
    Recipe.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60,
                  description: 'Recipe description', public: true, user:)
  end

  before do
    visit user_recipes_path(user)
  end

  it 'displays all the recipes' do
    expect(page).to_not have_selector('.recipe', count: 1)
  end

  it "displays each recipe's name" do
    Recipe.all.each do |recipe|
      expect(page).to have_selector('.recipe h5', text: "Recipe ##{recipe.id}: #{recipe.name}")
    end
  end

  it "displays each recipe's description" do
    Recipe.all.each do |recipe|
      expect(page).to have_selector('.recipe p', text: recipe.description)
    end
  end

  context 'when the user has permission to delete a recipe' do
    before do
      allow_any_instance_of(ActionController::Base).to receive(:current_user).and_return(user)
    end

    it "displays a 'Destroy this recipe' button for each recipe" do
      Recipe.all.each do |_recipe|
        expect(page).to have_button('Destroy this recipe', count: 1)
      end
    end
  end

  context 'when the user does not have permission to delete a recipe' do
    it "does not display a 'Destroy this recipe' button for any recipe" do
      Recipe.all.each do |_recipe|
        expect(page).to_not have_button('Destroy this recipe')
      end
    end
  end

  it "displays a 'View this recipe' link for each recipe" do
    Recipe.all.each do |recipe|
      expect(page).to have_link('View this recipe', href: user_recipe_path(user, recipe))
    end
  end
end
