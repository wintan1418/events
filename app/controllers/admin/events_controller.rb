module Admin
  class EventsController < BaseController
    def index
      @pagy, @events = pagy(Event.includes(:planner, :client).order(event_date: :desc))
    end

    def show
      @event = Event.friendly.find(params[:id])
    end
  end
end
