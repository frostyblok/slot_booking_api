require 'rails_helper'

RSpec.describe 'Schedule API', type: :request do

  describe 'GET /list_time_slots' do
    before { get '/schedules/list_time_slots', params: { 'day' => '2022-02-01', 'duration' => 1800 } }

    it 'returns a list of time slots' do
      json_response = JSON.parse(response.body)
      expect(json_response['result']).not_to be_empty
      expect(json_response['message']).to eq('Timeslots retrieved successfully')
    end
  end

  describe 'POST /create' do
    let(:start_time) { '15:00' }
    before { post '/schedules', params: { 'day' => '2022-02-01', 'start' => start_time, 'duration' => 30 }}

    it 'saves timeslot for 15:00 - 15:30 successfully' do
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Timeslot saved successfully')
    end

    context "#timeslots" do
      before { get '/schedules/list_time_slots', params: { 'day' => '2022-02-01', 'duration' => 1800 } }

      it 'ensure already take timeslots are not available' do
        json_response = JSON.parse(response.body)
        expect(json_response['result']).not_to include(start_time)
      end

    end
  end
end
