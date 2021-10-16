class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
  end

  def show
    @beers = Beer.where("brewery_id = #{params[:id]}")
    @brewery = Brewery.find(params[:id])
  end
end
