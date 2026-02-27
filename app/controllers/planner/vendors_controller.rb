module Planner
  class VendorsController < BaseController
    def index
      @pagy, @vendors = pagy(Vendor.active.order(name: :asc))
    end

    def show
      @vendor = Vendor.friendly.find(params[:id])
    end
  end
end
