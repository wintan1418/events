module VendorPortal
  class DashboardController < BaseController
    def show
      vendor = current_user.vendor_profile
      if vendor
        @event_vendors = vendor.event_vendors.includes(event: :client).order(created_at: :desc)
        @total_contracted = @event_vendors.sum(:contracted_amount)
        @total_paid = @event_vendors.sum(:paid_amount)
        @pending_payment = @total_contracted - @total_paid
      else
        @event_vendors = EventVendor.none
        @total_contracted = 0
        @total_paid = 0
        @pending_payment = 0
      end
    end
  end
end
