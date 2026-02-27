module VendorPortal
  class EventVendorsController < BaseController
    before_action :set_event

    def index
      @event_vendors = @event.event_vendors.joins(:vendor).where(vendors: { user_id: current_user.id })
    end

    def show
      @event_vendor = @event.event_vendors.joins(:vendor).where(vendors: { user_id: current_user.id }).find(params[:id])
    end

    def update
      @event_vendor = @event.event_vendors.joins(:vendor).where(vendors: { user_id: current_user.id }).find(params[:id])

      if @event_vendor.update(event_vendor_params)
        redirect_to vendor_portal_event_event_vendor_path(@event, @event_vendor), notice: "Updated."
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def set_event
      vendor = current_user.vendor_profile
      @event = vendor&.events&.friendly&.find(params[:event_id])
      redirect_to vendor_portal_dashboard_path, alert: "Event not found." unless @event
    end

    def event_vendor_params
      params.require(:event_vendor).permit(:notes)
    end
  end
end
