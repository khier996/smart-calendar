class EventSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :title
end
