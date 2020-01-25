require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe 'GET index' do
    it 'asks event model to return all events' do
      expect(Event).to receive(:all)
      get :index
    end

    it 'returns list of all events' do
      events = (1..rand(10)+1).to_a.map { create(:event) }
      expected_response = events.map do |event|
        {
          start_time: event.start_time,
          end_time: event.end_time,
          title: event.title
        }
      end.to_json

      get :index
      expect(response.body).to eq expected_response
    end
  end

  describe 'POST create' do
    let(:title) { 'meeting' }
    def send_create_request
      params = { event: { start_time: start_time, end_time: end_time, title: title } }
      post :create, body: params.to_json, as: :json
    end

    context 'params are correct' do
      let(:start_time) { Date.current.beginning_of_day }
      let(:end_time) { rand(10).days.from_now.end_of_day }

      it 'creates a new event' do
        expect { send_create_request }.to change { Event.count }.by(1)
        created_event = Event.last
        expect(created_event.start_time.to_s).to eq start_time.to_s
        expect(created_event.end_time.to_s).to eq end_time.to_s
        expect(created_event.title).to eq title
      end
    end

    context 'end_time is earlier than start_time' do
      let(:start_time) { Date.current.beginning_of_day }
      let(:end_time) { (rand(10) + 1).days.ago }

      it 'fails' do
        expect { send_create_request }.not_to change { Event.count }
        expect(response.code).to eq "400"
      end
    end
  end
end
