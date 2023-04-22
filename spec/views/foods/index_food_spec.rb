require 'rails_helper'

RSpec.describe 'food/index.html.erb', type: :feature do
  include Warden::Test::Helpers

  before(:each) do
    User.delete_all
    Recipe.delete_all
    Food.delete_all
    RecipeFood.delete_all

    @user = User.create!(name: 'Victor', email: 'victor@gmail.com', password: '123456')
    login_as(@user, scope: :user)
  end

  it 'visit user foods' do
    visit user_foods_path(@user)
    expect(page).to have_content('Food')
  end

  let(:recipe) do
    Recipe.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60,
                  description: 'Recipe description', public: true, user: @user)
  end

  let(:food) { Food.create(name: 'Eggs', user: @user, quantity: 2, measurement_unit: 'grams', price: 10) }
  it 'displays the list of foods' do
    visit user_foods_path(@user)
    Food.where(user: @user.id).each do |food|
      expect(page).to have_content(food.name)
      expect(page).to have_content(food.quantity)
      expect(page).to have_content(food.price)
    end
  end
end
