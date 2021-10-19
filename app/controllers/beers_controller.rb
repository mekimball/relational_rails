class BeersController < ApplicationController
  def index
    @beers = Beer.where("is_an_ale = true")
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def show_by_brewery
    @brewery = Brewery.find(params[:id])
    @beers = Beer.owned_by_brewery(params)
  end


  def new
    @beer = Beer.new
    @brewery = Brewery.find(params[:id])
  end

  def create
    @brewery = Brewery.find(params[:id])
    @beer = Beer.create({
      name: params[:beer][:name],
      abv: params[:beer][:abv],
      is_an_ale: params[:beer][:is_an_ale],
      brewery_id: @brewery.id
      })
    redirect_to "/breweries/#{params[:id]}/beers"
  end

  def edit
    @beer = Beer.find(params[:id])
  end

  def update
    beer = Beer.find(params[:id])
    beer.update({
      name: params[:beer][:name],
      abv: params[:beer][:abv],
      is_an_ale: params[:beer][:is_an_ale]
      })
    beer.save
    redirect_to "/beers/#{beer.id}"
  end

  def destroy
    Beer.destroy(params[:id])
    redirect_to '/beers'
  end
end
