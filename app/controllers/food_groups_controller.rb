class FoodGroupsController < ApplicationController
  def index
    @food_groups = FoodGroup.all
  end

  def show
    @food_group = FoodGroup.find(params[:id])
    @foods = @food_group.foods
  end

  def new
    @food_group = FoodGroup.new
  end

  def create
    FoodGroup.create({
      name: params[:food_group][:name],
      rating_out_of_ten: params[:food_group][:rating_out_of_ten],
      perishable: params[:food_group][:perishable]
      })
    redirect_to "/food_groups"
  end

  def edit
    @food_group = FoodGroup.find(params[:id])
  end

  def update
    food_group = FoodGroup.find(params[:id])
    food_group.update({
      name: params[:food_group][:name],
      rating_out_of_ten: params[:food_group][:rating_out_of_ten],
      perishable: params[:food_group][:perishable]
      })
      food_group.save
    redirect_to "/food_groups/#{food_group.id}"
  end

  def destroy
    Food.where(:food_group_id == params[:id]).delete_all
    FoodGroup.destroy(params[:id])
    redirect_to '/food_groups'
  end
end
