module Planner
  class EventsController < BaseController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    def index
      scope = Event.for_planner(current_user).includes(:client, :planner)
      scope = scope.where("title ILIKE ?", "%#{params[:q]}%") if params[:q].present?
      scope = scope.where(status: params[:status]) if params[:status].present?
      scope = params[:show] == "past" ? scope.past : scope.upcoming
      @pagy, @events = pagy(scope)
    end

    def show
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      @event.planner = current_user unless current_user.admin?

      if @event.save
        redirect_to planner_event_path(@event), notice: "Event created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @event.update(event_params)
        redirect_to planner_event_path(@event), notice: "Event updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @event.destroy
      redirect_to planner_events_path, notice: "Event deleted."
    end

    private

    def set_event
      @event = Event.friendly.find(params[:id])
    end

    def event_params
      params.require(:event).permit(
        :title, :description, :event_type, :event_date, :start_time, :end_time,
        :venue, :venue_address, :status, :budget_total, :estimated_guests,
        :notes, :client_id, :planner_id, :cover_image
      )
    end
  end
end
