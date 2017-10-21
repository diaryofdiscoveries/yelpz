require 'rails_helper'
require 'web_helper'

feature "reviews" do

  let!(:user){ User.create(email: "zoe@example.com", password: "123456") }
  let!(:pe){ Restaurant.create(name: "Pizza Express", address: "Kings road", description: "Italian", user_id: user.id) }

  scenario "user can add a review to a restaurant" do
    sign_in
    add_restaurant
    visit "/restaurants"
    click_link "Review Joe's"
    select("4", from: "review[rating]")
    fill_in("review[review]", with: "Great coffee")
    click_button "Create Review"
    # expect(current_path).to eq "/restaurants/1"
  end

  scenario "A user can not add more than one review for any restaurant" do
    sign_in
    visit "/restaurants/#{pe.id}"
    click_link "Add review"
    select("3", from: "review[rating]")
    fill_in("review[review]", with: "Delicious pizza, bad service")
    click_button "Create Review"
    expect(page).to have_content("zoe@example.com")

    visit "/restaurants/#{pe.id}"
    click_link "Add review"
    select("5", from: "review[rating]")
    fill_in("review[review]", with: "Service improved")
    click_button "Create Review"
    expect(current_path).to eq "/restaurants/#{pe.id}"
    expect(page).to_not have_content("Service improved")
    expect(page).to have_content("You have already reviewed this restaurant")
  end

  scenario "user can delete a review to a restaurant", js: true do
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
