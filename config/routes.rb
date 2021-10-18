Rails.application.routes.draw do
  get '/breweries', to: 'breweries#index'
  get '/breweries/new', to: 'breweries#new'
  post '/breweries', to: 'breweries#create'
  get '/breweries/:id/edit', to: 'breweries#edit'
  patch '/breweries/:id', to: 'breweries#update'
  get '/breweries/:id', to: 'breweries#show'
  get '/breweries/:id/beers', to: 'beers#show_by_brewery'
  post '/breweries/:id/beers', to: 'beers#create'
  get '/breweries/:id/beers/new', to: 'beers#new'
  delete '/breweries/:id', to: 'breweries#destroy'

  get '/beers', to: 'beers#index'
  get '/beers/:id', to: 'beers#show'
  get '/beers/:id/edit', to: 'beers#edit'
  patch '/beers/:id', to: 'beers#update'
  delete '/beers/:id', to: 'beers#destroy'
end
