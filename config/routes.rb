Rails.application.routes.draw do
  get '/breweries', to: 'breweries#index'
  get '/breweries/new', to: 'breweries#new'
  post '/breweries', to: 'breweries#create'
  get '/breweries/:id/edit', to: 'breweries#edit'
  patch '/breweries/:id', to: 'breweries#update'
  get '/breweries/:id', to: 'breweries#show'
  post '/breweries/:id/beers', to: 'beers#create'
  get '/breweries/:id/beers/new', to: 'beers#new'
  delete '/breweries/:id', to: 'breweries#destroy'

  get '/breweries/:id/beers', to: 'beers#show_by_brewery'

  get '/beers', to: 'beers#index'
  get '/beers/:id', to: 'beers#show'
  get '/beers/:id/edit', to: 'beers#edit'
  patch '/beers/:id', to: 'beers#update'
  delete '/beers/:id', to: 'beers#destroy'


  get '/food_groups', to: 'food_groups#index'
  get '/food_groups/new', to: 'food_groups#new'
  post '/food_groups', to: 'food_groups#create'
  get '/food_groups/:id/edit', to: 'food_groups#edit'
  patch '/food_groups/:id', to: 'food_groups#update'
  get '/food_groups/:id', to: 'food_groups#show'
  post '/food_groups/:id/foods', to: 'foods#create'
  get '/food_groups/:id/foods/new', to: 'foods#new'
  delete '/food_groups/:id', to: 'food_groups#destroy'

  get '/food_groups/:id/foods', to: 'foods#show_by_food_group'

  get '/foods', to: 'foods#index'
  get '/foods/:id', to: 'foods#show'
  get '/foods/:id/edit', to: 'foods#edit'
  patch '/foods/:id', to: 'foods#update'
  delete '/foods/:id', to: 'foods#destroy'
end
