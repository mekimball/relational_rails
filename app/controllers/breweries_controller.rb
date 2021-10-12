class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
  end

  def new

  end

  def show
    @breweries = Brewery.find(params[:id])
  end
  
  def edit
    @breweries = Brewery.find(params[:id])
  end
  
  def update
  end

  def delete
  end
end