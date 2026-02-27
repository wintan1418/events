module Client
  class BaseController < ApplicationController
    before_action :require_client!

    layout "client"

    private

    def require_client!
      require_role!(:client)
    end
  end
end
