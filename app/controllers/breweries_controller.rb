class BreweriesController < ApplicationController

  def create
    brewery = Brewery.new({
      name: params[:brewery][:name],
      number_of_employees: params[:brewery][:number_of_employees],
      has_food: params[:brewery][:has_food]
      })
  end
end
