class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    company_name = params[:user].delete(:company_name)

    account = Account.new(
      name: company_name.presence || "#{params[:user][:first_name]}'s Events",
      subdomain: generate_subdomain(company_name.presence || params[:user][:email]),
      plan_type: :free,
      email: params[:user][:email],
      active: true
    )

    if account.save
      ActsAsTenant.current_tenant = account
      params[:user][:account_id] = account.id
      params[:user][:role] = :planner

      build_resource(sign_up_params)
      resource.skip_confirmation!

      resource.save
      yield resource if block_given?

      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      build_resource(sign_up_params)
      resource.errors.add(:base, "Could not create your organization. Please try again.")
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :account_id, :role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :avatar])
  end

  def after_sign_up_path_for(resource)
    dashboard_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  private

  def generate_subdomain(input)
    base = input.to_s.parameterize.first(20)
    base = "events" if base.blank?
    subdomain = base
    counter = 1
    while Account.exists?(subdomain: subdomain)
      subdomain = "#{base}-#{counter}"
      counter += 1
    end
    subdomain
  end
end
