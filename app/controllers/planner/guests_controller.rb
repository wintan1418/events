module Planner
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
        redirect_to planner_event_guests_path(@event), notice: "Guest added."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @guest.update(guest_params)
        redirect_to planner_event_guests_path(@event), notice: "Guest updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @guest.destroy
      redirect_to planner_event_guests_path(@event), notice: "Guest removed."
    end

    def export
      @guests = @event.guests.alphabetical
      respond_to do |format|
        format.csv { send_data guests_csv, filename: "guests-#{@event.slug}.csv" }
      end
    end

    private

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end

    def set_guest
      @guest = @event.guests.find(params[:id])
    end

    def guest_params
      params.require(:guest).permit(:first_name, :last_name, :email, :phone, :rsvp_status, :dietary_notes, :table_number, :party_size, :meal_choice, :notes)
    end

    def guests_csv
      CSV.generate(headers: true) do |csv|
        csv << ["First Name", "Last Name", "Email", "RSVP", "Party Size", "Table", "Dietary Notes"]
        @guests.each do |guest|
          csv << [guest.first_name, guest.last_name, guest.email, guest.rsvp_status.humanize, guest.party_size, guest.table_number, guest.dietary_notes]
        end
      end
    end
  end
end
