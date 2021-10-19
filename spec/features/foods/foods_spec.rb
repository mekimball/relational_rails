require 'rails_helper'

RSpec.describe 'all foods tests' do
  before(:each) do
    @food_group1 = FoodGroup.create!({
                                  name: "Vegetables",
                                  rating_out_of_ten: 7,
                                  perishable: true
                                })
    # sleep 1
    @food_group2 = FoodGroup.create!({
                                  name: 'Canned Foods',
                                  rating_out_of_ten: 2,
                                  perishable: false
                                })
    @food1 = Food.create!({
                            name: 'Cucumbers',
                            number_in_stock: 72,
                            in_stock: true,
                            food_group_id: @food_group1.id
                          })
    @food2 = Food.create!({
                            name: 'Repeater',
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

  describe 'displays all foods when visiting the page' do
    it 'shows all food information for each food' do
      visit '/foods/'
      expect(page).to have_content(@food1.name)
      expect(page).to have_content(@food1.number_in_stock)
      expect(page).to have_content(@food1.in_stock)
      expect(page).to have_content(@food3.name)
      expect(page).to have_content(@food3.number_in_stock)
      expect(page).to have_content(@food3.in_stock)
    end
  end

  describe 'displays individual food information when visiting a food page' do
    it 'shows information for selected food page' do
      visit "/foods/#{@food1.id}"
      expect(page).to have_content(@food1.name)
      expect(page).to have_content(@food1.number_in_stock)
      expect(page).to have_content(@food1.in_stock)
    end

    it "doesn't show information for other foods" do
      visit "/foods/#{@food1.id}"
      expect(page).to_not have_content(@food2.name)
      expect(page).to_not have_content(@food2.number_in_stock)
      expect(page).to_not have_content(@food2.in_stock)
    end
  end

  describe 'displays food information when visiting a food_groups food page' do
    it 'shows information for food_group1 food page' do
      visit "/food_groups/#{@food_group1.id}/foods"

      expect(page).to have_content(@food1.name)
      expect(page).to have_content(@food1.number_in_stock)
      expect(page).to have_content(@food1.in_stock)
      expect(page).to have_content(@food2.name)
      expect(page).to have_content(@food2.number_in_stock)
      expect(page).to have_content(@food2.in_stock)
    end

    it 'does not show information for other food_group food pages' do
      visit "/food_groups/#{@food_group1.id}/foods"

      expect(page).to_not have_content(@food3.name)
      expect(page).to_not have_content(@food3.number_in_stock)
    end
  end
  describe 'creates a new food for a food_group' do
    it 'has a link to create a new food' do
      visit "/food_groups/#{@food_group1.id}/foods"

      expect(page).to have_content('Create Food')
    end

    it 'can create a food' do
      visit "/food_groups/#{@food_group1.id}/foods/new"

      page.fill_in('food[name]', with: 'Emergency Eating Food')
      page.fill_in('food[number_in_stock]', with: 0)
      page.fill_in('food[in_stock]', with: false)
      click_button('Create Food')

      expect(page).to have_content('Emergency Eating Food')
    end
  end

  describe 'creates a new food for a food_group' do
    it 'has an update link' do
      visit "/foods/#{@food1.id}"
      click_on('Update Food')

      expect(page).to have_content("Update #{@food1.name}")
    end

    it 'updates food information' do
      visit "/foods/#{@food1.id}/edit"

      page.fill_in('food[name]', with: 'Test Food')
      page.fill_in('food[number_in_stock]', with: 6.66)
      page.fill_in('food[in_stock]', with: false)
      click_button('Update Food')

      expect(page).to have_content('Test Food')
    end
  end

  it 'returns foods where in_stock is true' do
    visit '/foods'

    expect(page).to have_content(@food1.name)
    expect(page).to have_content(@food3.name)
    expect(page).to_not have_content(@food2.name)
  end

  it 'has a link to edit food page' do
    visit '/foods'

    click_on("Edit #{@food1.name}'s Info")

    expect(page).to have_content("Update #{@food1.name}")
  end

  it 'can delete foods' do
    visit "/foods/#{@food1.id}"

    click_on('Delete this Food')

    expect(page).to have_content('Foods')
    expect(page).to_not have_content(@food1.name.to_s)
  end

  it 'can delete foods from the food index' do
    visit '/foods'

    click_on("Delete #{@food1.name}")

    expect(page).to have_content('Foods')
    expect(page).to_not have_content(@food1.name.to_s)
  end
end
