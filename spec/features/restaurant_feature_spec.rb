require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurant has been added' do
    scenario 'should display restaurant' do
      Restaurant.create(name: "Pizza Express")
      visit '/restaurants'
      expect(page).to have_content("Pizza Express")
      expect(page).not_to have_content("No restaurants yet")
    end
  end
end