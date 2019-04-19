class BookingsController < ApplicationController

  def new
    passenger_number = params[:passenger_number].to_i
    @booking = Booking.new(flight_id: params[:flight_id])
    
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
             [:id, :name, :email])
        end
        
end
