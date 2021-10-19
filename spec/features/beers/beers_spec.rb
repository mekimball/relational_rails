require 'rails_helper'

RSpec.describe 'all beers tests' do
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
    visit '/beers'

    expect(page).to have_content(@beer1.name)
    expect(page).to have_content(@beer3.name)
    expect(page).to_not have_content(@beer2.name)
  end

  it 'has a link to edit beer page' do
    visit '/beers'

    click_on("Edit #{@beer1.name}'s Info")

    expect(page).to have_content("Update #{@beer1.name}")
  end

  it 'can delete beers' do
    visit "/beers/#{@beer1.id}"

    click_on('Delete this Beer')

    expect(page).to have_content('Beers')
    expect(page).to_not have_content(@beer1.name.to_s)
  end

  it 'can delete beers from the beer index' do
    visit '/beers'

    click_on("Delete #{@beer1.name}")

    expect(page).to have_content('Beers')
    expect(page).to_not have_content(@beer1.name.to_s)
  end
end
