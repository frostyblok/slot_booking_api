require 'rails_helper'

RSpec.describe BookedDay, type: :model do
  describe "#find" do
    let(:booked_days) do
      [
        { "id" => 1, "day" => "2022-02-01" },
        { "id" => 2, "day" => "2022-01-31" },
        { "id" => 3, "day" => "2022-02-01" }
      ]
    end

    before { allow(BookedDay).to receive(:all_days).and_return(booked_days)}
    context 'when day exists' do
      it 'returns booked day successfully' do
        expect(BookedDay.find(day: '2022-02-01')).not_to be_nil
        expect(BookedDay.find(day: '2022-02-01')).to be_a BookedDay
      end
    end

    context 'when day does not exist' do
      it 'returns booked day successfully' do
        expect(BookedDay.find(day: '2022-08-01')).to be_nil
      end
    end
  end
end
