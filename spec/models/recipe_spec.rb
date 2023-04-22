require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John', email: 'john@gmail.com', password: '1231231') }
  subject do
    described_class.create(name: 'Recipe Name', preparation_time: 30, cooking_time: 60,
                           description: 'Recipe description', public: true, user:)
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a name longer than 150 characters' do
      subject.name = 'a' * 151
      expect(subject).to_not be_valid
    end

    it 'is not valid without a preparation time' do
      subject.preparation_time = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a preparation time that is not a number' do
      subject.preparation_time = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a cooking time' do
      subject.cooking_time = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a cooking time that is not a number' do
      subject.cooking_time = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a description' do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a description longer than 500 characters' do
      subject.description = 'a' * 501
      expect(subject).to_not be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
