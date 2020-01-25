class EventSerializer < ActiveModel::Serializer
  attributes :start_time, :end_time, :title
end
