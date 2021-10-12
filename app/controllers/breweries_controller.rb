class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
  end

  def new
  end

  def create
    brewery = Brewery.new({
      created_at: Time.now,
      updated_at: Time.now,
      brewery_name: params[:brewery][:brewery_name],
      number_of_employees: params[:brewery][:number_of_employees],
      has_food: params[:brewery][:has_food]
    })
    brewery.save
    redirect_to "/breweries"
  end

  def show
    @breweries = Brewery.find(params[:id])
  end
  
  def edit
    @breweries = Brewery.find(params[:id])
  end

  def update
    brewery = Brewery.find(params[:id])
    brewery.update({
      updated_at: Time.now,
      brewery_name: params[:brewery][:brewery_name],
      number_of_employees: params[:brewery][:number_of_employees],
      has_food: params[:brewery][:has_food]
    })
    brewery.save
    redirect_to "/breweries/#{brewery.id}"
  end

  def destroy
    Brewery.destroy(params[:id])
    redirect_to "/breweries"
  end
end