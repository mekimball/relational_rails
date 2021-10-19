class CreateFoodGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :food_groups do |t|
      t.string :name
      t.float :rating_out_of_ten
      t.boolean :perishable

      t.timestamps
    end
  end
end
