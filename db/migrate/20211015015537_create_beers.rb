class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.float :abv
      t.boolean :is_an_ale

      t.timestamps
    end
  end
end
