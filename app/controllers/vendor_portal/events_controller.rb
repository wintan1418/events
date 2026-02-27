module VendorPortal
  class EventsController < BaseController
    def index
      vendor = current_user.vendor_profile
      if vendor
        @events = vendor.events.includes(:planner, :client).order(event_date: :desc)
      else
        @events = Event.none
      end
    end

    def show
      vendor = current_user.vendor_profile
      @event = vendor&.events&.friendly&.find(params[:id])
      redirect_to vendor_portal_dashboard_path, alert: "Event not found." unless @event
    end
  end
end
