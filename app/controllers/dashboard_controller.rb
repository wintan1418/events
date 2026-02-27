class DashboardController < ApplicationController
  def show
    redirect_to dashboard_path_for_role
  end

  private

  def dashboard_path_for_role
    case current_user.role
    when "admin"    then admin_dashboard_path
    when "planner"  then planner_dashboard_path
    when "client"   then client_dashboard_path
    when "vendor"   then vendor_portal_dashboard_path
    else root_path
    end
  end
end
