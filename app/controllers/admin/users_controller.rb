module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      scope = User.active.order(created_at: :desc)
      scope = scope.where("first_name ILIKE :q OR last_name ILIKE :q OR email ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
      scope = scope.where(role: params[:role]) if params[:role].present?
      @pagy, @users = pagy(scope)
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.account = current_user.account
      @user.skip_confirmation!

      if @user.save
        redirect_to admin_user_path(@user), notice: "User created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      params_to_use = user_params
      params_to_use = params_to_use.except(:password, :password_confirmation) if params_to_use[:password].blank?

      if @user.update(params_to_use)
        redirect_to admin_user_path(@user), notice: "User updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.update(active: false)
      redirect_to admin_users_path, notice: "User deactivated."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role, :phone, :password, :password_confirmation, :active)
    end
  end
end
