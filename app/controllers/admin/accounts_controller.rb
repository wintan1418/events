module Admin
  class AccountsController < BaseController
    def show
      @account = current_user.account
    end

    def edit
      @account = current_user.account
    end

    def update
      @account = current_user.account
      if @account.update(account_params)
        redirect_to admin_account_path, notice: "Account updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def account_params
      params.require(:account).permit(:name, :email, :phone, :website, :address, :logo)
    end
  end
end
