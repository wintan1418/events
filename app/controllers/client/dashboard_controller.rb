module Client
  class DashboardController < BaseController
    def show
      @events = Event.for_client(current_user).upcoming.includes(:planner, :tasks, :guests, :timelines, :line_items)
      @event = @events.first
      @all_events = Event.for_client(current_user).includes(:planner)
      @past_events = Event.for_client(current_user).past.limit(3)
    end
  end
end
