require 'rails_helper'

RSpec.describe User, type: :model do
  after(:all) do
      User.delete_all
      Recipe.delete_all
      Food.delete_all
      RecipeFood.delete_all
  end

  let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }

  describe "associations" do
    it { should have_many(:recipes) }
    it { should have_many(:foods) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
  end

  describe "devise modules" do
    let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }

    it "should be database authenticatable" do
      expect(user.valid_password?('1231231')).to be true
    end

    it "should include database_authenticatable in the list of devise modules" do
        expect(user.class.devise_modules).to include(:database_authenticatable)
      end

    it "should be database authenticatable" do
      expect(user).to be_database_authenticatable
    end
  end
end
