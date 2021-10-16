require 'rails_helper'

RSpec.describe 'the breweries show page' do
  before(:each) do
    @brewery1 = Brewery.create!({
      name: "Bob's Pub",
      number_of_employees: 635432,
      has_food: true
      })
    # sleep 1
    @brewery2 = Brewery.create!({
      name: "Ratio",
      number_of_employees: 655432,
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

  describe 'displays beer information when visiting a breweries beer page' do
    it 'shows information for brewery1 beer page' do
      visit "/breweries/#{@brewery1.id}/beers"

      expect(page).to have_content(@beer1.name)
      expect(page).to have_content(@beer1.abv)
      expect(page).to have_content(@beer1.is_an_ale)
      expect(page).to have_content(@beer2.name)
      expect(page).to have_content(@beer2.abv)
      expect(page).to have_content(@beer2.is_an_ale)
    end

    it 'does not show information for other brewery beer pages' do
      visit "/breweries/#{@brewery1.id}/beers"

      expect(page).to_not have_content(@beer3.name)
      expect(page).to_not have_content(@beer3.abv)
    end
  end

  # NEEDS A BETTER TEST
  # it 'breweries are sorted by creation date, newest to oldest' do
  #   visit '/breweries'
  #
  #   save_and_open_page
  # end

  it 'brewery show page shows how many individual beers are associated with that brewery' do
    visit "/breweries/#{@brewery1.id}"

    expect(page).to have_content("Serves 2 different beers.")
  end

  it 'has a link to the breweries index at the top of the page' do
    visit "/breweries/#{@brewery1.id}"
    click_on('Breweries Index')

    expect(page).to have_content("Breweries")

    visit "/beers"
    click_on('Breweries Index')

    expect(page).to have_content("Breweries")
  end

  it 'has a link to the beers index at the top of the page' do
    visit "/breweries/#{@brewery1.id}"
    click_on('Beers Index')

    expect(page).to have_content("All Beers:")

    visit "/beers"
    click_on('Beers Index')

    expect(page).to have_content("All Beers:")
  end

  it 'breweries show page has a link to the beers for said brewery' do
    visit "/breweries/#{@brewery1.id}"
    click_on("All Beers Served by #{@brewery1.name}")

    expect(page).to have_content("Beers served by #{@brewery1.name}")
  end
  
  describe 'creates a new brewery' do
    it 'has a link to create a new brewery record' do
      
      visit "/breweries"
      
      click_on("Add a new brewery")
      
      expect(page).to have_content("Create a New Brewery:")
    end

    it 'creates a new brewery record' do
      visit "breweries/new"

      page.fill_in('brewery[name]', with: 'Test Brewery')
      page.fill_in('brewery[number_of_employees]', with: 26)
      page.fill_in('brewery[has_food]', with: true)
      click_button('Create Brewery')
      save_and_open_page
      expect(page).to have_content("Test Brewery")
    end
  end
end

# As a visitor
# When I visit the Parent Index page
# Then I see a link to create a new Parent record, "New Parent"
# When I click this link
# Then I am taken to '/parents/new' where I  see a form for a new parent record
# When I fill out the form with a new parent's attributes:
# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route,
# a new parent record is created,
# and I am redirected to the Parent Index page where I see the new Parent displayed.