Rails.application.routes.draw do
  root 'flights#index'
  get 'flights/new'
  get 'flights/index'

  resources :flights
  resources :bookings
end
