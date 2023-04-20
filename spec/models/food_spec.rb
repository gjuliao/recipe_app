require 'rails_helper'

RSpec.describe Food, type: :model do
  after(:all) do
    User.delete_all
    Recipe.delete_all
    Food.delete_all
    RecipeFood.delete_all
  end
  describe 'validations' do
    it 'requires name to be present' do
      food = Food.new(name: nil)
      expect(food.valid?).to be false
      expect(food.errors[:name]).to include("can't be blank")
    end

    it 'requires name to be at most 150 characters' do
      food = Food.new(name: 'a' * 151)
      expect(food.valid?).to be false
      expect(food.errors[:name]).to include('is too long (maximum is 150 characters)')
    end

    it 'requires measurement_unit to be present' do
      food = Food.new(measurement_unit: nil)
      expect(food.valid?).to be false
      expect(food.errors[:measurement_unit]).to include("can't be blank")
    end

    it 'requires measurement_unit to be at most 10 characters' do
      food = Food.new(measurement_unit: 'a' * 11)
      expect(food.valid?).to be false
      expect(food.errors[:measurement_unit]).to include('is too long (maximum is 10 characters)')
    end

    it 'requires price to be present' do
      food = Food.new(price: nil)
      expect(food.valid?).to be false
      expect(food.errors[:price]).to include("can't be blank")
    end

    it 'requires price to be a number' do
      food = Food.new(price: 'not a number')
      expect(food.valid?).to be false
      expect(food.errors[:price]).to include('is not a number')
    end

    it 'requires quantity to be present' do
      food = Food.new(quantity: nil)
      expect(food.valid?).to be false
      expect(food.errors[:quantity]).to include("can't be blank")
    end

    it 'requires quantity to be a number' do
      food = Food.new(quantity: 'not a number')
      expect(food.valid?).to be false
      expect(food.errors[:quantity]).to include('is not a number')
    end

    it 'requires user_id to be present' do
      food = Food.new(user_id: nil)
      expect(food.valid?).to be false
      expect(food.errors[:user_id]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '.shoping_list' do
    # let(:user1) { User.create(name: 'John') }
    User.delete_all
    Recipe.delete_all
    Food.delete_all
    RecipeFood.delete_all
    user1 = User.create(name: 'John', email: 'john@gmail.com', password: '1231231')

    it 'returns a hash of food names and quantities' do
      eggs = Food.create(name: 'Eggs', user: user1, quantity: 2, measurement_unit: 'grams', price: 10)
      bread = Food.create(name: 'Bread', user: user1, quantity: 5, measurement_unit: 'grams', price: 10)
      recipe1 = Recipe.create(name: 'Scrambled eggs', preparation_time: 5, cooking_time: 5, description: 'Very simple',
                              public: true, user: user1)
      recipe2 = Recipe.create(name: 'Bread', preparation_time: 5, cooking_time: 5, description: 'Very simple',
                              public: true, user: user1)
      RecipeFood.create(food: eggs, quantity: 12, recipe: recipe1)
      RecipeFood.create(food: bread, quantity: 1, recipe: recipe2)

      expect(Food.shoping_list(user1)).to eq({ 'Eggs' => 10 })
    end
  end
end
