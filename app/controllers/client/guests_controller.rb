module Client
  class GuestsController < BaseController
    before_action :set_event
    before_action :set_guest, only: [:show, :edit, :update, :destroy]

    def index
      @pagy, @guests = pagy(@event.guests.alphabetical)
    end

    def show
    end

    def new
      @guest = @event.guests.build
    end

    def create
      @guest = @event.guests.build(guest_params)

      if @guest.save
        redirect_to client_event_guests_path(@event), notice: "Guest added."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @guest.update(guest_params)
        redirect_to client_event_guests_path(@event), notice: "Guest updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @guest.destroy
      redirect_to client_event_guests_path(@event), notice: "Guest removed."
    end

    private

    def set_event
      @event = Event.for_client(current_user).friendly.find(params[:event_id])
    end

    def set_guest
      @guest = @event.guests.find(params[:id])
    end

    def guest_params
      params.require(:guest).permit(:first_name, :last_name, :email, :phone, :rsvp_status, :dietary_notes, :table_number, :party_size, :meal_choice, :notes)
    end
  end
end
