require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:appointment) do
    u = User.create(id: 7, name: 'User', last_name: 'Seven', email: 'useronex@email.com', password: "123qwe")
    c = Client.create(id: 23, name: 'Client', last_name: 'TwentyThree', email: 'clientone@email.com', phone_number: "1234567890")
    l = Location.create(
      id: 134,
      name: "Place one",
      address: "Main street 1",
      postal_code: "99999",
      city: "City three",
      state: "State four",
      notes: "The place is between the other place"
    )

    Appointment.new(
      user: u,
      client: c,
      location: l,
      scheduled_at: Time.local(2025, 02, 20, 14, 30), # use local time (Mexico city)
      duration: 30,
      notes: "Appointment notes"
    )
  end

  let(:appointment_2) do
    Appointment.create(
      user: appointment.user,
      client: appointment.client,
      location: appointment.location,
      scheduled_at: appointment.scheduled_at + (60 * 60 * 24 * 5), # plus 5 days
      status: 0,
      duration: appointment.duration,
    )
  end

  context 'appointment code' do
    it 'must be "000476C"' do
      appointment.save

      expect(appointment.code).to eq "2502201430-000476C"
    end
    it 'must be different to another appointment with same user, client, location and time but diferent day' do
      expect(appointment.valid?).to be true
      expect(appointment.code).not_to eq appointment_2.code
    end
  end

  context 'Valid' do
    it 'when all fields are present' do
      expect(appointment).to be_valid
    end

    it 'when not present notes' do
      appointment.notes = nil

      expect(appointment).to be_valid
    end
  end

  context 'Invalid' do
    it 'when user is not present' do
      appointment.user = nil

      expect(appointment).not_to be_valid
    end

    it 'when client is not present' do
      appointment.client = nil

      expect(appointment).not_to be_valid
    end

    it 'when location is not present' do
      appointment.location = nil

      expect(appointment).not_to be_valid
    end

    it 'when scheduled_at is not present' do
      appointment.scheduled_at = nil

      expect(appointment).not_to be_valid
    end

    it 'when two appointments with the same client at the same time' do
      appointment.scheduled_at = appointment_2.scheduled_at
      appointment.user = User.create(
        id: 405,
        name: "User",
        last_name: "FiveOFive",
        email: "fiveofive@email.com",
      )
      appointment.valid?
      expect(appointment.errors[:client].first).to eq "Client already with an appointment in the scheduled date"
      expect(appointment.errors[:user]).to be_empty
      expect(appointment).not_to be_valid
    end

    it 'when two appointments with the same user at the same time' do
      appointment.scheduled_at = appointment_2.scheduled_at
      appointment.client = Client.create(
        id: 812,
        name: "Client",
        last_name: "Two",
        email: "clienttwo@email.com",
        phone_number: "0987654321",
      )
      appointment.valid?
      expect(appointment.errors[:client]).to be_empty
      expect(appointment.errors[:user].first).to eq "User already with an appointment in the scheduled date"
      expect(appointment).not_to be_valid
    end
  end

  context 'appointment code' do
    it 'invalid when' do
      appointment.code = appointment_2.code
      expect(appointment).not_to be_valid
    end
  end
end
