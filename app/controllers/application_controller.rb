class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :set_current_account

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_account
    return unless current_user
    ActsAsTenant.current_tenant = current_user.account
  end

  def require_role!(*roles)
    unless roles.any? { |role| current_user.send("#{role}?") }
      redirect_to root_path, alert: "Access denied."
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
