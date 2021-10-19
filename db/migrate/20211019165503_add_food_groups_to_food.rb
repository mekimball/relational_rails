class AddFoodGroupsToFood < ActiveRecord::Migration[5.2]
  def change
    add_reference :foods, :food_groups, foreign_key: true
  end
end
