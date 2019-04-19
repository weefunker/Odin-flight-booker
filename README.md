# README

Things I learned from this project 
======

## Associations 

After struggling with the associations from the Eventbrite project. I came into this over thinking it a little. A lot of the notes that acted as a vague build guide in The Odin Project made me confused. Especially when they talked about using ```inverse_of``` so much as if it was going to be crucial. 

### Has many belongs to association for two key model

```
class Flight < ApplicationRecord
    belongs_to :start_airport, class_name: "Airport", foreign_key: "start_airport_id"
    belongs_to :end_airport, class_name: "Airport", foreign_key: "end_airport_id"
```


```
class Airport < ApplicationRecord
    has_many :flights 
    has_many :start_airports, class_name: "Flight", foreign_key: "start_airport_id"
    has_many :end_airports, class_name: "Flight", foreign_key: "end_airport_id"
    has_many :departing_flights, through: :start_airports
    has_many :arriving_flights, through: :end_airports
end
```

This was rather tricky to implement. After seeing how some people skipped this step entirely with just using self methods and indexes. Kinda annoyed me. How much of this is over engineered I am not sure. 

## Options for select 

In order to populate each dropdown I needed to access all of the options for each flight in a handy manner. In my flights index controller this is what I came up with after some googling.

```
    @flight_start_options = Flight.all.map {|f| [f.start_airport.name, f.start_airport.id] }
    @flight_end_options = Flight.all.map {|f| [f.end_airport.name, f.end_airport.id] }
    @flight_date_options = Flight.all.map {|f| [f.date] }
```

### Debugging tools are useful 

Both of these parameter debugging tools came in very handy during this project. I doubt I would have gotten far without them.

```
<%= params.inspect %>
```
```
<%= debug(params) if Rails.env.development? %>
```

## Get request form

```
<%= form_for flights_path, :method => :get do %>
<%= select_tag( :start_airport, options_for_select(@flight_start_options) )%>
<%= select_tag( :end_airport, options_for_select(@flight_end_options) )%>
<%= select_tag( :date, options_for_select(@flight_date_options) )%>

<%= fields_for @passengers do |p| %>
    <%= p.label :passengers %>
    <%= p.select(:passenger_number, (1..4)) %>
<% end %>

<%= submit_tag "Submit" %>
<% end %>
```

Here the passengers bit was looked up. The basic premise for this type of form and how it works is difficult to google. Most of the results pertaining to forms are just basic post request creation forms. Even rarer still are the forms that involve dropdowns. I luckily found a video tutorial of a guy explaining the basic premise for this. 

## Scopes and chained scopes 

I didn't use scopes at all in the previous project because I didn't understand them or why you would use them over a self calling method. Turns out they are a lot easier to understand and use. 

```
  scope :start_search_results, -> (start_airport) {where start_airport: start_airport}
  scope :end_search_results, -> (end_airport) {where end_airport: end_airport}
  scope :date_search_results, -> (date) {where date: date}
```

This makes it very handy when you want to call all three of them in a controller to use as a form filter. 

```
if params[:start_airport] and params[:end_airport]
    @flights = 
    Flight.start_search_results(params[:start_airport]).end_search_results(params[:end_airport]).date_search_results(params[:date])
else 
    flash[:danger] = "No flights found"
    @flights = Flight.all 
end
```

## Blank form for passing params 

```
<%= form_for '', url: new_booking_path, method: :get do |f| %>
    <%= hidden_field_tag(:passengers, params[:passenger_number]) %>
    <%= render @flights %>
    <%= f.submit %>
<% end %>
```

Here the form is targeting a blank string ''. This needed to be looked up as it completely stumped me. During the steps laid out in the project. They don't even have you create a booking controller at that point so needless to say I was lost at this point for days. Using the hidden field tag is necessary too because it is required in order for the params to pass onto the booking path.

### Flight Partials and radio button select

```
 <%= radio_button_tag :flight_id, flight.id  %>
 <%= flight.start_airport.name %>
 <%= flight.end_airport.name %>
 <%= flight.date %>
 <%= params[:number_of_passengers] %>
 
```

A good example of using a radio button to pass the class of a chosen object in a view to the next controller path. Also I have not really used partials that much thus far so it was great to see how useful they can be in de-cluttering your workspace. 

## Booking form accepts nested attributes for 

Here was the most complex part of the project. Again this required a lot of looking up solutions. Even then it was a struggle to actually get it to work . 

```
<%= form_for @booking, url: bookings_path do |booking| %>
  <%= booking.hidden_field :flight_id, value: @booking.flight_id %>
  <% params[:passengers].to_i.times do %>
<%= booking.fields_for :passengers, @booking.passengers.build do |p| %>
<%= p.text_field :name %>
<%= p.text_field :email %>
<br>
<% end %>
<% end %>
<%= booking.submit %>
<% end %>
```

The params containing the amount of passengers is passed into this form from the previous ```new_booking_path``` in the flights index form. Then the nested attributes attribute modifier from the booking model gets called on the amount of passengers to build a passenger inside the form. 

## Bookings controller whitelist nested params and hold passenger number

```
class BookingsController 
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
  params.require(: booking).permit(:flight_id,: passengers_attributes => [:id,:name,:email])
end
```

Here the new action keeps track of the ```passenger_number``` params. A new booking when called takes a the flight id from the params also. 

On create we use the ```booking_params``` strong parameters to whitelist both the flight id and the nested passenger attributes. 

Summary
======

Overall the project was the most challenging to date purely because of the lack of decent examples to work with on Google. Anything I looked up didn't lead to progress and sometimes even sent me back a few steps.
 
I learned a lot regardless of having to look up the solution at the end after being stuck for nearly a week. However I missed an opportunity for growth and it will bug me a lot, considering that I had the tools and knowledge to make it work. In future I will ask for help a lot more often on The Odin Project chat.









