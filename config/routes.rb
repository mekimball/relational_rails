Rails.application.routes.draw do
  get '/breweries', to: 'breweries#index'
  get '/breweries/:id', to: 'breweries#show'
  get '/beers', to: 'beers#index'
  get '/beers/:id', to: 'beers#show'
end
