module Planner
  class TimelinesController < BaseController
    before_action :set_event
    before_action :set_timeline, only: [:edit, :update, :destroy]

    def index
      @timelines = @event.timelines.ordered
    end

    def new
      @timeline = @event.timelines.build
    end

    def create
      @timeline = @event.timelines.build(timeline_params)

      if @timeline.save
        redirect_to planner_event_timelines_path(@event), notice: "Timeline entry added."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @timeline.update(timeline_params)
        redirect_to planner_event_timelines_path(@event), notice: "Timeline entry updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @timeline.destroy
      redirect_to planner_event_timelines_path(@event), notice: "Timeline entry removed."
    end

    private

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end

    def set_timeline
      @timeline = @event.timelines.find(params[:id])
    end

    def timeline_params
      params.require(:timeline).permit(:start_time, :end_time, :title, :description, :responsible_party, :location, :position)
    end
  end
end
