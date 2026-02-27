module Planner
  class EventVendorsController < BaseController
    before_action :set_event
    before_action :set_event_vendor, only: [:show, :edit, :update, :destroy]

    def index
      @event_vendors = @event.event_vendors.includes(:vendor)
    end

    def show
    end

    def new
      @event_vendor = @event.event_vendors.build
    end

    def create
      @event_vendor = @event.event_vendors.build(event_vendor_params)

      if @event_vendor.save
        redirect_to planner_event_event_vendors_path(@event), notice: "Vendor assigned."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @event_vendor.update(event_vendor_params)
        redirect_to planner_event_event_vendor_path(@event, @event_vendor), notice: "Vendor updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @event_vendor.destroy
      redirect_to planner_event_event_vendors_path(@event), notice: "Vendor removed."
    end

    private

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end

    def set_event_vendor
      @event_vendor = @event.event_vendors.find(params[:id])
    end

    def event_vendor_params
      params.require(:event_vendor).permit(:vendor_id, :contracted_amount, :paid_amount, :status, :notes, :service_date, contracts: [])
    end
  end
end
