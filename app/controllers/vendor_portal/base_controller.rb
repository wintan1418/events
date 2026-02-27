module VendorPortal
  class BaseController < ApplicationController
    before_action :require_vendor!

    layout "vendor_portal"

    private

    def require_vendor!
      require_role!(:vendor)
    end
  end
end
