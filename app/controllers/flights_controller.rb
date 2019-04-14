class FlightsController < ApplicationController
  def new
  end

  def index

    @flight_start_options = Flight.all.map {|f| [f.start_airport.name, f.start_airport.id] }
    @flight_end_options = Flight.all.map {|f| [f.end_airport.name, f.end_airport.id] }
    @flight_date_options = Flight.all.map {|f| [f.date] }

    if params[:start_airport] and params[:end_airport]
      @flights = 
      Flight.start_search_results(params[:start_airport]).end_search_results(params[:end_airport])
    else 
      flash.now[:danger] = "No flights found"
      @flights = Flight.all 
    end
  end   
    
    # @flights = @flights.start_airport(params[:start_airport]) if params[:start_airport].present?
    # @flights = @flights.end_airport(params[:end_airport]) if params[:end_airport].present?
    # @flights = @flights.date(params[:date]) if params[:date].present?
    # @flights = Flight.where(nil)
    # flight_params(params).each do |key, value|
    #   @flights = @flights.public_send(key, value) if value.present?
    # end
  


  private

  def flight_params
    params.require(:flight).permit(:start_airport, :end_airport, :date)
  end


  
end
