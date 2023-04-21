require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }
  let(:recipe) do
    Recipe.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60, description: 'Recipe description',
                  public: true, user:)
  end
  let(:food) { Food.create(name: 'Eggs', user:, quantity: 2, measurement_unit: 'grams', price: 10) }
  subject { described_class.create(quantity: 2, recipe:, food:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a quantity' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a quantity that is not a number' do
      subject.quantity = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a recipe' do
      subject.recipe = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a food' do
      subject.food = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end
end
