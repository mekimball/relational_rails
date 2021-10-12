Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  get '/breweries', to: 'breweries#index'
  get '/breweries/new', to: 'breweries#new'
  post '/breweries', to: 'breweries#create'
  get '/breweries/:id', to: 'breweries#show'
end
