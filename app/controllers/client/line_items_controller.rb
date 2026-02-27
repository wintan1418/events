module Client
  class LineItemsController < BaseController
    before_action :set_event

    def index
      @line_items = @event.line_items.order(category: :asc)
    end

    def show
      @line_item = @event.line_items.find(params[:id])
    end

    private

    def set_event
      @event = Event.for_client(current_user).friendly.find(params[:event_id])
    end
  end
end
