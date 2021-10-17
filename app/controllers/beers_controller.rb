class BeersController < ApplicationController
  def index
    @beers = Beer.where("is_an_ale = true")
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def show_by_brewery
    @brewery = Brewery.find(params[:id])
    @beers = Beer.where("brewery_id = #{params[:id]}")
    @beers = @beers.sort_by{|beer| beer.name}
  end

  def show_by_brewery_alphabetically
    @brewery = Brewery.find(params[:id])
    @beers = Beer.where("brewery_id = #{params[:id]}")
    @beers = @beers.sort_by{|beer| beer.name}
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
      # require 'pry'; binding.pry
      beer.save
      redirect_to "/beers/#{beer.id}"
  end
end
