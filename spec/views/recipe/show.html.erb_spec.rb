require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :feature do
    User.delete_all
    Recipe.delete_all
    Food.delete_all
    RecipeFood.delete_all
  
    let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }
  
    let(:recipe) do
      Recipe.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60,
                    description: 'Recipe description', public: true, user: user)
    end

    before do
      login_as(user)
      visit user_recipe_path(user, recipe)
    end
    
    it 'displays the recipe name' do
      expect(page).to have_content(recipe.name)
    end
    
    it 'displays the recipe description' do
      expect(page).to have_content(recipe.description)
    end
    
    it 'displays the list of recipe foods' do
      RecipeFood.where(recipe_id: recipe.id).each do |recipe_food|
        expect(page).to have_content(recipe_food.food.name)
        expect(page).to have_content(recipe_food.quantity)
        expect(page).to have_content(recipe_food.food.price)
      end
    end
    
    context 'when user has delete permissions' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(RecipePolicy).to receive(:destroy?).and_return(true)
        visit user_recipe_path(user, recipe)
      end
      
      it 'displays delete button for each recipe food' do
        RecipeFood.where(recipe_id: recipe.id).each do |recipe_food|
          within("#recipe_food_#{recipe_food.id}") do
            expect(page).to have_selector("input[type=submit][value='Delete']")
          end
        end
      end
    end
    
    context 'when user does not have delete permissions' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(RecipePolicy).to receive(:destroy?).and_return(false)
        visit user_recipe_path(user, recipe)
      end
      
      it 'does not display delete button for any recipe food' do
        RecipeFood.where(recipe_id: recipe.id).each do |recipe_food|
          within("#recipe_food_#{recipe_food.id}") do
            expect(page).not_to have_selector("input[type=submit][value='Delete']")
          end
        end
      end
    end
    
    it 'has a link to edit the recipe' do
      expect(page).to have_link('Edit this recipe', href: edit_user_recipe_path(user, recipe))
    end
    
    it 'has a link to go back to the recipes list' do
      expect(page).to have_link('Back to recipes', href: user_recipes_path(user))
    end
    
  end
  