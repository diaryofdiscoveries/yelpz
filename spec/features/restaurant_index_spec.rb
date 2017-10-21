require 'rails_helper'
require 'web_helper'

feature "restaurants" do

  let!(:user1){ User.create(email: "zoe@example.com", password: "123456") }
  let!(:pe){ Restaurant.create(name: "Pizza Express", address: "Kings road", description: "Italian", user_id: user1.id) }

  context "restaurants are visible in the list of restaurants" do
    scenario "should display 2 restaurants after creating them" do
      sign_in
      visit '/restaurants/new'
      fill_in('restaurant[name]', :with => "McDonalds")
      fill_in('restaurant[address]', :with => "Piccadilly Circus")
      fill_in('restaurant[description]', :with => "Burgers")
      click_button('Create Restaurant')
      visit '/restaurants'
      expect(page).to have_content("Pizza Express")
      expect(page).to have_content("McDonalds")
      expect(page).not_to have_content("No restaurants yet")
    end
  end
end
