require 'rails_helper'

RSpec.describe Beer do
  it {should belong_to :brewery}

  before(:each) do
    @brewery1 = Brewery.create!({
                                  name: "Bob's Pub",
                                  number_of_employees: 635_432,
                                  has_food: true
                                })
    @brewery2 = Brewery.create!({
                                  name: 'Ratio',
                                  number_of_employees: 655_222,
                                  has_food: false
                                })
    @beer1 = @brewery1.beers.create!({
                            name: 'Spotted Cow',
                            abv: 4.5,
                            is_an_ale: true
                          })
    @beer2 = @brewery1.beers.create!({
                            name: 'Repeater',
                            abv: 6.2,
                            is_an_ale: false
                          })
    @beer3 = @brewery2.beers.create!({
                            name: 'Hold Steady',
                            abv: 8.0,
                            is_an_ale: true
                          })
  end

  describe '#owned_by_brewery' do
    it 'returns beers associated with current brewery' do
      test = {id: @brewery1.id}

      expect(Beer.owned_by_brewery(test)).to eq([@beer1, @beer2])
    end
    
    it 'alphabetizes beers' do
    test = {id: @brewery1.id,
            q: 'alpha'}

      expect(Beer.owned_by_brewery(test)).to eq([@beer2, @beer1])
    end
    
    it 'can filter by beer abv' do
    test = {id: @brewery1.id,
            abv: 5}

      expect(Beer.owned_by_brewery(test)).to eq([@beer2])
    end
  end
end