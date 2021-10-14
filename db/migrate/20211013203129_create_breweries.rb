class CreateBreweries < ActiveRecord::Migration[5.2]
  def change
    create_table :breweries do |t|
      t.string :name
      t.integer :number_of_employees
      t.boolean :has_food

      t.timestamps
    end
  end
end
