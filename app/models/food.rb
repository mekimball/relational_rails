class Food < ApplicationRecord
  belongs_to :food_group

  def self.owned_by_food_group(params)
    sorted_foods = self.where("food_group_id = #{params[:id]}")
    sorted_foods = sorted_foods.order(:name) if params[:q] == 'alpha'
    sorted_foods = sorted_foods.where("number_in_stock > #{params[:number_in_stock]}") unless params[:number_in_stock].nil?
    sorted_foods
    end

  def self.in_stock
    self.where("in_stock = true")
  end
end
