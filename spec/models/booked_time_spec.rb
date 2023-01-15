require 'rails_helper'

RSpec.describe BookedTime, type: :model do
  describe "#booked_for" do
    let(:booked_times) do
      [
        { "id" => 1, "start" => "2022-02-01T20:00:00.000Z", "end" => "2022-02-01T22:30:00.000Z", "booked_day_id" => 1 },
        { "id" => 2, "start" => "2022-01-31T23:00:00.000Z", "end" => "2022-02-01T06:00:00.000Z", "booked_day_id" => 1 },
        { "id" => 3, "start" => "2022-02-01T10:15:00.000Z", "end" => "2022-02-01T10:45:00.000Z", "booked_day_id" => 1 },
        { "id" => 4, "start" => "2022-02-01T13:55:00.000Z", "end" => "2022-02-01T14:30:00.000Z", "booked_day_id" => 1 },
        { "id" => 5, "start" => "2022-02-02T10:00:00.000Z", "end" => "2022-02-02T20:00:00.000Z", "booked_day_id" => 1 },
        { "id" => 6, "start" => "2022-02-01T09:00:00.000Z", "end" => "2022-02-01T10:00:00.000Z", "booked_day_id" => 1 },
        { "id" => 7, "start" => "2022-02-01T11:30:00.000Z", "end" => "2022-02-01T13:00:00.000Z", "booked_day_id" => 1 },
        { "id" => 8, "start" => "2022-02-01T13:00:00.000Z", "end" => "2022-02-01T13:10:00.000Z", "booked_day_id" => 1 }
      ]
    end
    let(:booked_day_id) { 1 }

    before { allow(BookedTime).to receive(:all_times).and_return(booked_times)}
    context 'when day exists' do
      it 'returns booked day successfully' do
        expect(BookedTime.booked_for(booked_day_id: booked_day_id)).not_to be_nil
      end
    end

    context 'when day does not exist' do
      it 'returns booked day successfully' do
        expect(BookedTime.booked_for(booked_day_id: 2)).to eq([])
      end
    end
  end
end
