class BookingsController < ApplicationController

    def new
        number_of_passengers = params[:number_of_passengers].to_i
        @booking = Booking.new(flight_id: params[:flight_id])
        number_of_passengers.times { @booking.passengers.build}
      end
    
    
      def create
        @booking = Booking.create!(booking_params)
        redirect_to @booking
      end
    
      def show
        @booking = Booking.find(params[:id])
        @flight = @booking.flight_id
      end
    
      private
        def booking_params
           params.require(:booking).permit(:flight_id, :passengers_attributes =>
             [:id, :name, :address, :city, :state, :zipcode])
        end
        
end
