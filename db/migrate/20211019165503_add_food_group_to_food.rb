class AddFoodGroupToFood < ActiveRecord::Migration[5.2]
  def change
    add_reference :foods, :food_group, foreign_key: true
  end
end
