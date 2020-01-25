class Event < ApplicationRecord
  validates_presence_of :start_time, :end_time, :title
  validate :validate_end_is_later

  private

  def validate_end_is_later
    if start_time > end_time
      self.errors.add(:end_time, 'should be later than start_time')
    end
  end
end
