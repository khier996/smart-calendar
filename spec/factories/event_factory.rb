FactoryBot.define do
  factory :event do
    start_time { Date.current }
    end_time { Date.tomorrow }
    title { 'important meeting' }
  end
end
