class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
  end

  def show
    @beers = Beer.where("brewery_id = #{params[:id]}")
    @brewery = Brewery.find(params[:id])
  end

  def new
    @brewery = Brewery.new
  end

  def create
    Brewery.create({
      name: params[:brewery][:name],
      number_of_employees: params[:brewery][:number_of_employees],
      has_food: params[:brewery][:has_food]
      })
    redirect_to "/breweries"
  end

  def edit
    @brewery = Brewery.find(params[:id])
  end

  def update
    brewery = Brewery.find(params[:id])
    brewery.update({
      name: params[:brewery][:name],
      number_of_employees: params[:brewery][:number_of_employees],
      has_food: params[:brewery][:has_food]
      })
      brewery.save
    redirect_to "/breweries/#{brewery.id}"
  end

  def destroy
    Beer.where(:brewery_id == params[:id]).delete_all
    Brewery.destroy(params[:id])
    redirect_to '/breweries'
  end
end
