module Admin
  class VendorsController < BaseController
    before_action :set_vendor, only: [:show, :edit, :update, :destroy]

    def index
      @pagy, @vendors = pagy(Vendor.active.order(name: :asc))
    end

    def show
    end

    def new
      @vendor = Vendor.new
    end

    def create
      @vendor = Vendor.new(vendor_params)
      if @vendor.save
        redirect_to admin_vendor_path(@vendor), notice: "Vendor created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @vendor.update(vendor_params)
        redirect_to admin_vendor_path(@vendor), notice: "Vendor updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @vendor.update(active: false)
      redirect_to admin_vendors_path, notice: "Vendor deactivated."
    end

    private

    def set_vendor
      @vendor = Vendor.friendly.find(params[:id])
    end

    def vendor_params
      params.require(:vendor).permit(:name, :category, :email, :phone, :website, :address, :notes, :active, :logo)
    end
  end
end
