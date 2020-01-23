module Api
  module V1
    class EventsController < ApplicationController

      def create
        render json: { success: true }
      end

    end
  end
end
