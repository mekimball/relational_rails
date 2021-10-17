require 'rails_helper'

RSpec.describe 'the breweries show page' do
  before(:each) do
    @brewery1 = Brewery.create!({
                                  name: "Bob's Pub",
                                  number_of_employees: 635_432,
                                  has_food: true
                                })
    # sleep 1
    @brewery2 = Brewery.create!({
                                  name: 'Ratio',
                                  number_of_employees: 655_432,
                                  has_food: false
                                })
    @beer1 = Beer.create!({
                            name: 'Spotted Cow',
                            abv: 4.5,
                            is_an_ale: true,
                            brewery_id: @brewery1.id
                          })
    @beer2 = Beer.create!({
                            name: 'Repeater',
                            abv: 6.2,
                            is_an_ale: false,
                            brewery_id: @brewery1.id
                          })
    @beer3 = Beer.create!({
                            name: 'Hold Steady',
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

    expect(page).to have_content('Serves 2 different beers.')
  end

  it 'has a link to the breweries index at the top of the page' do
    visit "/breweries/#{@brewery1.id}"
    click_on('Breweries Index')

    expect(page).to have_content('Breweries')

    visit '/beers'
    click_on('Breweries Index')

    expect(page).to have_content('Breweries')
  end

  it 'has a link to the beers index at the top of the page' do
    visit "/breweries/#{@brewery1.id}"
    click_on('Beers Index')

    expect(page).to have_content('All Beers:')

    visit '/beers'
    click_on('Beers Index')

    expect(page).to have_content('All Beers:')
  end

  it 'breweries show page has a link to the beers for said brewery' do
    visit "/breweries/#{@brewery1.id}"
    click_on("All Beers Served by #{@brewery1.name}")

    expect(page).to have_content("Beers served by #{@brewery1.name}")
  end

  describe 'creates a new brewery' do
    it 'has a link to create a new brewery record' do
      visit '/breweries'

      click_on('Add a new brewery')

      expect(page).to have_content('Create a New Brewery:')
    end

    it 'creates a new brewery record' do
      visit 'breweries/new'

      page.fill_in('brewery[name]', with: 'Test Brewery')
      page.fill_in('brewery[number_of_employees]', with: 26)
      page.fill_in('brewery[has_food]', with: true)
      click_button('Create Brewery')
      save_and_open_page
      expect(page).to have_content('Test Brewery')
    end
  end

  describe 'updates an existing brewery' do
    it 'has a link for update brewery' do
      visit "/breweries/#{@brewery1.id}"

      click_on('Update Brewery')

      expect(page).to have_content("Update #{@brewery1.name}")
    end

    it 'updates brewery information' do
      visit "/breweries/#{@brewery1.id}/edit"

      page.fill_in('brewery[name]', with: 'Test Brewery')
      page.fill_in('brewery[number_of_employees]', with: 26)
      page.fill_in('brewery[has_food]', with: false)
      click_button('Update Brewery')

      expect(page).to have_content('Test Brewery')
    end
  end

  describe 'creates a new beer for a brewery' do
    it 'has a link to create a new beer' do
      visit "/breweries/#{@brewery1.id}/beers"

      expect(page).to have_content('Create Beer')
    end

    it 'can create a beer' do
      visit "/breweries/#{@brewery1.id}/beers/new"

      page.fill_in('beer[name]', with: 'Emergency Drinking Beer')
      page.fill_in('beer[abv]', with: 5.7)
      page.fill_in('beer[is_an_ale]', with: false)
      click_button('Create Beer')

      expect(page).to have_content('Emergency Drinking Beer')
    end
  end

  describe 'creates a new beer for a brewery' do
    it 'has an update link' do

      visit "/beers/#{@beer1.id}"
      click_on('Update Beer')

      expect(page).to have_content("Update #{@beer1.name}")
    end
    
    it 'updates beer information' do
      visit "/beers/#{@beer1.id}/edit"

      page.fill_in('beer[name]', with: 'Test Beer')
      page.fill_in('beer[abv]', with: 6.66)
      page.fill_in('beer[is_an_ale]', with: false)
      click_button('Update Beer')

      expect(page).to have_content('Test Beer')
    end
  end


  it 'returns beers where is_an_ale is true' do
    visit "/beers"

    expect(page).to have_content(@beer1.name)
    expect(page).to have_content(@beer3.name)
    expect(page).to_not have_content(@beer2.name)
    save_and_open_page
  end

  it 'can sort alphabetically' do
    beer5 = Beer.create!({
                            name: 'A Spotted Cow',
                            abv: 4.5,
                            is_an_ale: true,
                            brewery_id: @brewery1.id
                          })
    visit "/breweries/#{@brewery1.id}/beers"

    click_on "Sort Alphabetically"
  end

  describe 'has a link to edit from index pages' do
    it 'has a link to edit brewery page' do
      visit "/breweries"

      click_on("Edit #{@brewery1.name}'s Info")

      expect(page).to have_content("Update #{@brewery1.name}")
    end

    it 'has a link to edit beer page' do
      visit "/beers"

      click_on("Edit #{@beer1.name}'s Info")

      expect(page).to have_content("Update #{@beer1.name}")
    end
  end
end

# As a visitor
# When I visit the Parent's children Index Page
# Then I see a link to sort children in alphabetical order
# When I click on the link
# I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order