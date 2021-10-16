Rails.application.routes.draw do
  get '/breweries', to: 'breweries#index'
  get '/breweries/new', to: 'breweries#new'
  get '/breweries/:id/edit', to: 'breweries#edit'
  post '/breweries', to: 'breweries#create'
  patch '/breweries/:id', to: 'breweries#update'
  get '/breweries/:id', to: 'breweries#show'
  get '/beers', to: 'beers#index'
  get '/beers/:id', to: 'beers#show'
  get '/breweries/:id/beers', to: 'beers#show_by_brewery'
  post '/breweries/:id/beers', to: 'beers#create'
  get '/breweries/:id/beers/new', to: 'beers#new'
end
