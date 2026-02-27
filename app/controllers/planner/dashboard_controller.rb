module Planner
  class DashboardController < BaseController
    def show
      @my_events = Event.for_planner(current_user).upcoming.limit(6).includes(:client, :tasks)
      @tasks_due = Task.for_user(current_user).due_soon.by_priority.includes(:event, :assigned_to)
      @overdue_tasks = Task.for_user(current_user).overdue.by_priority.includes(:event, :assigned_to)
      @upcoming_count = Event.for_planner(current_user).upcoming.count
      @total_events = Event.for_planner(current_user).count
      @completed_events = Event.for_planner(current_user).completed.count
      @total_tasks = Task.for_user(current_user).count
      @completed_tasks = Task.for_user(current_user).completed.count
      @recent_tasks = Task.for_user(current_user).where.not(status: :completed).by_priority.limit(8).includes(:event, :assigned_to)
    end
  end
end
