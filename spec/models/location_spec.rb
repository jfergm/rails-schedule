require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) do
    build(:location)
  end

  context 'Valid' do
    it 'when all fields are set' do
      expect(location).to be_valid
    end

    it 'when notes are not present' do
      location.notes = nil
      expect(location).to be_valid
    end
  end

  context 'Invalid' do
    it 'when name are not present' do
      location.name = nil

      expect(location).not_to be_valid
    end

    it 'when address is not present' do
      location.address = nil

      expect(location).not_to be_valid
    end

    it 'when postal_code is not present' do
      location.postal_code = nil

      expect(location).not_to be_valid
    end

    it 'when city is not present' do
      location.city = nil

      expect(location).not_to be_valid
    end

    it 'when state is not present' do
      location.state = nil

      expect(location).not_to be_valid
    end

    before do
      create(
        :location,
        address: location.address,
        postal_code: location.postal_code,
        city: location.city,
        state: location.state,
        notes: location.notes
      )
    end
    it 'when address and postal_code are not unique' do
      expect(location).not_to be_valid
    end
  end
end
