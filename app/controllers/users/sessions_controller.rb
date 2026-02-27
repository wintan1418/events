class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path_for(resource)
  end

  private

  def dashboard_path_for(user)
    case user.role
    when "admin"    then admin_dashboard_path
    when "planner"  then planner_dashboard_path
    when "client"   then client_dashboard_path
    when "vendor"   then vendor_portal_dashboard_path
    else root_path
    end
  end
end
