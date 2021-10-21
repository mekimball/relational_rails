require 'rails_helper'

RSpec.describe Food do
  it {should belong_to :food_group}

  before(:each) do
    @food_group1 = FoodGroup.create!({
                                  name: "Vegetables",
                                  rating_out_of_ten: 7,
                                  perishable: true
                                })
    @food_group2 = FoodGroup.create!({
                                  name: 'Canned Foods',
                                  rating_out_of_ten: 2,
                                  perishable: false
                                })
    @food1 = @food_group1.foods.create!({
                            name: 'Cucumbers',
                            number_in_stock: 72,
                            in_stock: true
                          })
    @food2 = @food_group1.foods.create!({
                            name: 'Celery',
                            number_in_stock: 0,
                            in_stock: false
                          })
    @food3 = @food_group2.foods.create!({
                            name: 'Beans',
                            number_in_stock: 132,
                            in_stock: true
                          })
  end

  describe '#owned_by_food_group' do
    it 'returns foods associated with current food_group' do
      test = {id: @food_group1.id}

      expect(Food.owned_by_food_group(test)).to eq([@food1, @food2])
    end

    it 'alphabetizes foods' do
    test = {id: @food_group1.id,
            q: 'alpha'}

      expect(Food.owned_by_food_group(test)).to eq([@food2, @food1])
    end

    it 'can filter by food number_in_stock' do
    test = {id: @food_group1.id,
            number_in_stock: 50}

      expect(Food.owned_by_food_group(test)).to eq([@food1])
    end
  end

  describe '#in_stock' do
    it 'returns only foods that are in stock' do
      expect(Food.in_stock).to eq([@food1, @food3])
      expect(Food.in_stock).to_not include(@food2)
    end
  end
end
