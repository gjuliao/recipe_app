require 'rails_helper'

RSpec.describe User, type: :model do
  after(:all) do
    User.delete_all
    Recipe.delete_all
    Food.delete_all
    RecipeFood.delete_all
  end

  let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }

  describe 'associations' do
    it { should have_many(:recipes) }
    it { should have_many(:foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
  end

  describe 'devise modules' do
    it 'should have valid password' do
      expect(user.valid_password?('1231231')).to be true
    end

    it 'Name should have MIN length' do
      user1 = User.create(name: 'J', email: 'john@hotmail.com', password: '1231231')
      expect(user1.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'Name should have MAX length' do
      user1 = User.create(name: 'Frank Sinatra' * 10, email: 'john@hotmail.com', password: '1231231')
      expect(user1.errors[:name]).to include('is too long (maximum is 50 characters)')
    end

    it 'Presence of Password' do
      user1 = User.create(name: 'Frank Sinatra', email: 'jhon@email.com', password: '')
      expect(user1).to_not be_valid
      expect(user1.errors[:password]).to include("can't be blank")
    end

    it 'Presence of Email' do
      user1 = User.create(name: 'Frank Sinatra', email: '', password: '1231231')
      expect(user1).to_not be_valid
      expect(user1.errors[:email]).to include("can't be blank")
    end

    it 'should include database_authenticatable in the list of devise modules' do
      expect(user.class.devise_modules).to include(:database_authenticatable)
    end

    it 'should be database authenticatable' do
      expect(user).to be_database_authenticatable
    end
  end
end
