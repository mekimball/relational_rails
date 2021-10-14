require 'rails_helper'

RSpec.describe 'the breweries show page' do
  it 'displays the names of each brewery in the system' do
    brewery1 = Brewery.create!({
      name: "Bob's Pub",
      number_of_employees: 20,
      has_food: true
      })
    brewery2 = Brewery.create!({
      name: "Ratio",
      number_of_employees: 15,
      has_food: false
      })
    visit '/breweries'

    expect(page).to have_content(brewery1.name)
    expect(page).to_not have_content(brewery1.number_of_employees)
    expect(page).to_not have_content(brewery1.has_food)
    expect(page).to have_content(brewery2.name)
    expect(page).to_not have_content(brewery2.number_of_employees)
    expect(page).to_not have_content(brewery2.has_food)
  end
end

# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system
