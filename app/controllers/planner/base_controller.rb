module Planner
  class BaseController < ApplicationController
    before_action :require_planner!

    layout "planner"

    private

    def require_planner!
      require_role!(:planner, :admin)
    end
  end
end
