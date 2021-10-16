class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def show_by_brewery
    require 'pry'; binding.pry
    @brewery = Brewery.find(params[:id])
    @beers = Beer.where("brewery_id = #{params[:id]}")
  end

  def new
    @beer = Beer.new
    @brewery = Brewery.find(params[:id])
  end
  
  def create
    @brewery = Brewery.find(params[:id])
    @beer = Beer.new({ 
      name: params[:beer][:name],
      abv: params[:beer][:abv],
      is_an_ale: params[:beer][:is_an_ale],
      brewery_id: @brewery.id
      })
      @beer.save
    redirect_to "/breweries/:id/beers"
  end
end
