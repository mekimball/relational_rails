require 'rails_helper'

RSpec.describe 'the breweries show page' do
  before(:each) do
    @brewery1 = Brewery.create!({
      name: "Bob's Pub",
      number_of_employees: 20,
      has_food: true
      })
    @brewery2 = Brewery.create!({
      name: "Ratio",
      number_of_employees: 15,
      has_food: false
      })
    @beer1 = Beer.create!({
      name: "Spotted Cow",
      abv: 4.5,
      is_an_ale: true,
      brewery_id: @brewery1.id
      })
    @beer2 = Beer.create!({
      name: "Repeater",
      abv: 6.2,
      is_an_ale: false,
      brewery_id: @brewery1.id
      })
    @beer3 = Beer.create!({
      name: "Hold Steady",
      abv: 8.0,
      is_an_ale: true,
      brewery_id: @brewery2.id
      })
  end

  describe 'displays the names of each brewery in the system' do
    it 'displays all names' do
      visit '/breweries'
      expect(page).to have_content(@brewery1.name)
      expect(page).to have_content(@brewery2.name)
    end

    it "doesn't display other information" do
      visit '/breweries'
      expect(page).to_not have_content(@brewery1.number_of_employees)
      expect(page).to_not have_content(@brewery1.has_food)
      expect(page).to_not have_content(@brewery2.number_of_employees)
      expect(page).to_not have_content(@brewery2.has_food)
    end
  end
  describe 'displays individual brewery information when visiting its page' do
    it 'shows all information for given brewery' do
      visit "/breweries/#{@brewery1.id}"
      expect(page).to have_content(@brewery1.name)
      expect(page).to have_content(@brewery1.number_of_employees)
      expect(page).to have_content(@brewery1.has_food)
    end

    it "doesn't display information for other breweries" do
      visit "/breweries/#{@brewery1.id}"
      expect(page).to_not have_content(@brewery2.name)
      expect(page).to_not have_content(@brewery2.number_of_employees)
      expect(page).to_not have_content(@brewery2.has_food)
    end
  end

  describe 'displays all beers when visiting the page' do
    it 'shows all beer information for each beer' do
      visit '/beers/'
      expect(page).to have_content(@beer1.name)
      expect(page).to have_content(@beer1.abv)
      expect(page).to have_content(@beer1.is_an_ale)
      expect(page).to have_content(@beer3.name)
      expect(page).to have_content(@beer3.abv)
      expect(page).to have_content(@beer3.is_an_ale)
    end
  end

  describe 'displays individual beer information when visiting a beer page' do
    it 'shows information for selected beer page' do
      visit "/beers/#{@beer1.id}"
      expect(page).to have_content(@beer1.name)
      expect(page).to have_content(@beer1.abv)
      expect(page).to have_content(@beer1.is_an_ale)
    end

    it "doesn't show information for other beers" do
      visit "/beers/#{@beer1.id}"
      expect(page).to_not have_content(@beer2.name)
      expect(page).to_not have_content(@beer2.abv)
      expect(page).to_not have_content(@beer2.is_an_ale)
    end
  end
end

# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes:
