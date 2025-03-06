require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  context 'Valid' do
    it 'when all fields are present' do
      expect(client).to be_valid
    end

    it 'when last_name is not present' do
      client.last_name = nil

      expect(client).to be_valid
    end
  end

  context 'Invalid' do
    it 'when name is not present' do
      client.name = nil

      expect(client).not_to be_valid
    end

    it 'when email is not present' do
      client.email = nil

      expect(client).not_to be_valid
    end

    it 'when phone is not present' do
      client.phone_number = nil

      expect(client).not_to be_valid
    end

    before { create(:client, email: client.email, phone_number: client.phone_number) }
    it 'when email is repeated' do
      expect(client).not_to be_valid
    end
  end
end
