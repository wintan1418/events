module Admin
  class DashboardController < BaseController
    def show
      @total_events = Event.count
      @active_planners = User.planners.active.count
      @active_clients = User.clients.active.count
      @active_vendors = Vendor.active.count
      @upcoming_events = Event.upcoming.limit(5).includes(:planner, :client)
      @recent_events = Event.order(created_at: :desc).limit(5).includes(:planner, :client)
      @total_budget = Event.sum(:budget_total)
      @events_this_month = Event.where(event_date: Date.current.beginning_of_month..Date.current.end_of_month).count
      @team_members = User.active.order(created_at: :desc).limit(5)
    end
  end
end
