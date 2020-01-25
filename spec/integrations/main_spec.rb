require 'rails_helper'

describe 'Main page', type: :feature, js: true do
  let(:event_title) { 'important event' }
  before do
    create(:event, start_time: Date.current, end_time: Date.tomorrow, title: event_title)
    visit('/')
    wait_for_ajax
  end

  it 'shows existing event' do
    expect(page).to have_css('.fc-event-container')
    expect(page.first('.fc-event-container .fc-title').text).to eq event_title
  end

  context 'create legit event' do
    let(:new_event_title) { 'meeting' }
    let(:new_event_duration) { 1 }
    it 'creates new event' do
      page.all('.fc-day').last.click
      expect(page).to have_css('.create-event-popup')
      page.all('.create-event-popup input')[0].set(new_event_title)
      page.all('.create-event-popup input')[1].set(new_event_duration)

      expect { click_create_event_btn }.to change { Event.count }.by(1)
      expect(Event.last.title).to eq new_event_title
    end
  end

  context 'title is missing' do
    let(:new_event_title) { nil }
    let(:new_event_duration) { 1 }

    it 'creates new event' do
      page.all('.fc-day').last.click
      expect(page).to have_css('.create-event-popup')
      page.all('.create-event-popup input')[0].set(new_event_title)
      page.all('.create-event-popup input')[1].set(new_event_duration)

      expect { click_create_event_btn }.not_to change { Event.count }
    end
  end
end

def click_create_event_btn
  page.find('.create-event-popup .cal-btn').click
  wait_for_ajax
end
