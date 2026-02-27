module Client
  class TimelinesController < BaseController
    before_action :set_event

    def index
      @timelines = @event.timelines.ordered
    end

    private

    def set_event
      @event = Event.for_client(current_user).friendly.find(params[:event_id])
    end
  end
end
