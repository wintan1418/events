module Client
  class EventsController < BaseController
    def index
      @events = Event.for_client(current_user).includes(:planner)
    end

    def show
      @event = Event.for_client(current_user).friendly.find(params[:id])
    end
  end
end
