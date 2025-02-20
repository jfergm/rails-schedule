require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'My name', last_name: 'My last name', email: 'myemail@email.com') }
  context 'Should be valid' do
    it 'with name, last_name, email' do
      expect(user).to be_valid
    end

    it 'when last_name is not present' do
      user.last_name = nil

      expect(user).to be_valid
    end
  end

  context 'Should not be valid' do
    it 'when name is not present' do
      user.name = nil

      expect(user).not_to be_valid
    end
    it 'when email is not present' do
      user.email = nil

      expect(user).not_to be_valid
    end

    before { User.create(name: 'Name', email: user.email) }
    it 'when email is already taken' do
      expect(user).not_to be_valid
    end
  end
end
