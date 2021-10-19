require 'rails_helper'

RSpec.describe 'all food_groups tests' do
  before(:each) do
    @food_group1 = FoodGroup.create!({
                                  name: "Vegetables",
                                  rating_out_of_ten: 7.5,
                                  perishable: true
                                })
    @food_group2 = FoodGroup.create!({
                                  name: 'Canned Foods',
                                  rating_out_of_ten: 1.3,
                                  perishable: false
                                })
    @food1 = Food.create!({
                            name: 'Cucumbers',
                            number_in_stock: 73,
                            in_stock: true,
                            food_group_id: @food_group1.id
                          })
    @food2 = Food.create!({
                            name: 'Carrots',
                            number_in_stock: 0,
                            in_stock: false,
                            food_group_id: @food_group1.id
                          })
    @food3 = Food.create!({
                            name: 'Beans',
                            number_in_stock: 132,
                            in_stock: true,
                            food_group_id: @food_group2.id
                          })
  end

  describe 'displays the names of each food_group in the system' do
    it 'displays all names' do
      visit '/food_groups'
      expect(page).to have_content(@food_group1.name)
      expect(page).to have_content(@food_group2.name)
    end

    it "doesn't display other information" do
      visit '/food_groups'
      expect(page).to_not have_content(@food_group1.rating_out_of_ten)
      expect(page).to_not have_content(@food_group1.perishable)
      expect(page).to_not have_content(@food_group2.rating_out_of_ten)
      expect(page).to_not have_content(@food_group2.perishable)
    end
  end
  describe 'displays individual food_group information when visiting its page' do
    it 'shows all information for given food_group' do
      visit "/food_groups/#{@food_group1.id}"
      expect(page).to have_content(@food_group1.name)
      expect(page).to have_content(@food_group1.rating_out_of_ten)
      expect(page).to have_content(@food_group1.perishable)
    end

    it "doesn't display information for other food_groups" do
      visit "/food_groups/#{@food_group1.id}"
      expect(page).to_not have_content(@food_group2.name)
      expect(page).to_not have_content(@food_group2.rating_out_of_ten)
      expect(page).to_not have_content(@food_group2.perishable)
    end
  end
  it 'food_groups are sorted by creation date, newest to oldest' do
    visit '/food_groups'

    expect('Canned Foods').to appear_before("Vegetables")
  end

  it 'food_group show page shows how many individual foods are associated with that food_group' do
    visit "/food_groups/#{@food_group1.id}"

    expect(page).to have_content('Includes 2 different foods.')
  end

  it 'has a link to the food_groups index at the top of the page' do
    visit "/food_groups/#{@food_group1.id}"
    click_on('Food Group Index')

    expect(page).to have_content('Food Groups')

    visit '/foods'
    click_on('Food Group Index')

    expect(page).to have_content('Food Groups')
  end

  it 'has a link to the foods index at the top of the page' do
    visit "/food_groups/#{@food_group1.id}"
    click_on('Foods Index')

    expect(page).to have_content('All Foods:')

    visit '/foods'
    click_on('Foods Index')

    expect(page).to have_content('All Foods:')
  end

  it 'food_groups show page has a link to the foods for said food_group' do
    visit "/food_groups/#{@food_group1.id}"
    click_on("All Foods included in: #{@food_group1.name}")

    expect(page).to have_content("Foods that are #{@food_group1.name}")
  end

  describe 'creates a new food_group' do
    it 'has a link to create a new food_group record' do
      visit '/food_groups'

      click_on('Add a new Food Group')

      expect(page).to have_content('Create a New Food Group:')
    end

    it 'creates a new food_group record' do
      visit 'food_groups/new'

      page.fill_in('food_group[name]', with: 'Test Food Group')
      page.fill_in('food_group[rating_out_of_ten]', with: 7.5)
      page.fill_in('food_group[perishable]', with: true)
      click_button('Create Food Group')

      expect(page).to have_content('Test Food Group')
    end
  end

  describe 'updates an existing food_group' do
    it 'has a link for update food_group' do
      visit "/food_groups/#{@food_group1.id}"

      click_on('Update Food Group')

      expect(page).to have_content("Update #{@food_group1.name}")
    end

    it 'updates food_group information' do
      visit "/food_groups/#{@food_group1.id}/edit"

      page.fill_in('food_group[name]', with: 'Test FoodGroup')
      page.fill_in('food_group[rating_out_of_ten]', with: 7.5)
      page.fill_in('food_group[perishable]', with: false)
      click_button('Update Food Group')

      expect(page).to have_content('Test FoodGroup')
    end
  end

  it 'can sort alphabetically' do
    food5 = Food.create!({
                           name: 'Anchovies',
                           number_in_stock: 73,
                           in_stock: true,
                           food_group_id: @food_group1.id
                         })
    visit "/food_groups/#{@food_group1.id}/foods"

    click_on 'Sort Alphabetically'

    expect('Anchovies').to appear_before('Carrots')
    expect('Carrots').to appear_before('Cucumbers')
  end

  describe 'has a link to edit from index pages' do
    it 'has a link to edit food_group page' do
      visit '/food_groups'

      click_on("Edit #{@food_group1.name}'s Info")

      expect(page).to have_content("Update #{@food_group1.name}")
    end
  end

  it 'can delete food_groups' do
    visit "/food_groups/#{@food_group1.id}"

    click_on('Delete this Food Group')

    expect(page).to have_content('Food Groups')
    expect(page).to_not have_content(@food_group1.name.to_s)
  end

  it 'can filter foods by a certain specified amount in stock' do
    visit "/food_groups/#{@food_group1.id}/foods"

    page.fill_in('number_in_stock', with: '20')

    click_on('Filter')

    expect(page).to_not have_content(@food2.name.to_s)
    expect(page).to have_content(@food1.name.to_s)
  end

  it 'can delete food_groups from the food_group index' do
    visit '/food_groups'

    click_on("Delete #{@food_group1.name}")

    expect(page).to have_content('Food Groups')
    expect(page).to_not have_content(@food_group1.name.to_s)
  end
end
