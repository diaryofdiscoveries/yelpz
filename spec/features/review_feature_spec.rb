require 'rails_helper'
require 'web_helper'

feature "reviews" do

  scenario "user can add a review to a restaurant" do
    sign_up
    sign_in
    add_restaurant
    visit "/restaurants"
    click_link "Review Joe's"
    select("4", from: "review[rating]")
    fill_in("review[review]", with: "Great coffee")
    click_button "Create Review"
    # expect(current_path).to eq "/restaurants/1"
  end

  scenario "user can delete a review to a restaurant", js: true do
    sign_up
    sign_in
    add_restaurant
    visit "/restaurants"
    click_link "Review Joe's"
    select("4", from: "review[rating]")
    fill_in("review[review]", with: "Great coffee")
    click_button "Create Review"
    # expect(current_path).to eq "/restaurants/1"
    expect(page).to have_content("Great coffee")
    click_link('Destroy Review')
    page.driver.browser.switch_to.alert.accept
    # expect(current_path).to eq '/restaurants/1'
    expect(page).not_to have_content('Great coffee')
  end
end
