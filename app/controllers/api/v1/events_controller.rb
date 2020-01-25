module Api
  module V1
    class EventsController < ApplicationController

      def index
        render json: Event.all
      end

      def create
        event = Event.new(event_params)
        if event.valid?
          event.save
          render json: { success: true, event: event }
        else
          render json: { succes: false }, status: 400
        end
      end

      private

      def event_params
        params.require(:event).permit(:start_time, :end_time, :title)
      end

    end
  end
end
