class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :number_in_stock
      t.boolean :in_stock

      t.timestamps
    end
  end
end
