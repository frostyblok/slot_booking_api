require 'rails_helper'

RSpec.describe 'TimeSlot' do
  describe "#build_timeslots" do
    it 'returns an array of available timeslots with 15-minute intervals' do
      booked_day = BookedDay.find(day: '2022-02-01')
      time_slots = TimeSlot.build_timeslots(booked_day, 1800)
      intervals = (Time.parse(time_slots[1]) - Time.parse(time_slots[0])) / 60

      expect(time_slots).to be_an_instance_of(Array)
      expect(intervals).to eq(15)
    end
  end
end
