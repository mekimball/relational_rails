class FoodsController < ApplicationController
  def index
    @foods = Food.in_stock
  end

  def show
    @food = Food.find(params[:id])
  end

  def show_by_food_group
    @food_group = FoodGroup.find(params[:id])
    @foods = Food.owned_by_food_group(params)
  end


  def new
    @food = Food.new
    @food_group = FoodGroup.find(params[:id])
  end

  def create
    @food_group = FoodGroup.find(params[:id])
    @food = Food.create({
      name: params[:food][:name],
      number_in_stock: params[:food][:number_in_stock],
      in_stock: params[:food][:in_stock],
      food_group_id: @food_group.id
      })
    redirect_to "/food_groups/#{params[:id]}/foods"
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    food = Food.find(params[:id])
    food.update({
      name: params[:food][:name],
      number_in_stock: params[:food][:number_in_stock],
      in_stock: params[:food][:in_stock]
      })
    food.save
    redirect_to "/foods/#{food.id}"
  end

  def destroy
    Food.destroy(params[:id])
    redirect_to '/foods'
  end
end
