module Planner
  class LineItemsController < BaseController
    before_action :set_event
    before_action :set_line_item, only: [:edit, :update, :destroy]

    def index
      @line_items = @event.line_items.order(category: :asc)
    end

    def new
      @line_item = @event.line_items.build
    end

    def create
      @line_item = @event.line_items.build(line_item_params)

      if @line_item.save
        redirect_to planner_event_line_items_path(@event), notice: "Budget item added."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @line_item.update(line_item_params)
        redirect_to planner_event_line_items_path(@event), notice: "Budget item updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @line_item.destroy
      redirect_to planner_event_line_items_path(@event), notice: "Budget item removed."
    end

    private

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end

    def set_line_item
      @line_item = @event.line_items.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:category, :description, :estimated_cost, :actual_cost, :paid, :notes, :event_vendor_id)
    end
  end
end
