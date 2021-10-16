class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def show_by_brewery
    @brewery = Brewery.find(params[:id])
    @beers = Beer.where("brewery_id = #{params[:id]}")
  end
end
