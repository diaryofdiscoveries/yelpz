require 'rails_helper'
require 'web_helper'

feature "restaurants" do

  context "restaurants are visible in the list of restaurants" do
    scenario "should display 2 restaurants after creating them" do
      sign_up
      sign_in
      add_restaurant
      visit '/restaurants/new'
      fill_in('restaurant[name]', :with => "McDonalds")
      fill_in('restaurant[address]', :with => "Piccadilly Circus")
      fill_in('restaurant[description]', :with => "Burgers")
      click_button('Create Restaurant')
      visit '/restaurants'
      expect(page).to have_content("Joe's")
      expect(page).to have_content("McDonalds")
      expect(page).not_to have_content("No restaurants yet")
    end
  end
end
