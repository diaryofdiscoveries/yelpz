require 'rails_helper'
require 'web_helper'

feature "reviews" do

  let!(:user1){ User.create(email: "zoe@example.com", password: "123456") }
  let!(:user2){ User.create(email: "sam@example.com", password: "654321") }
  let!(:pe){ Restaurant.create(name: "Pizza Express", address: "Kings road", description: "Italian", user_id: user1.id) }
  let!(:cr){ Restaurant.create(name: "Cafe Rouge", address: "Kensington Church street", description: "French", user_id: user2.id) }

  context("Signed in") do

    before { sign_in }

    scenario "user cannot add a review to their own restaurant" do
      click_link("Sign out")
      sign_in(email: "zoe@example.com", password: "123456")
      visit "/restaurants"
      expect(page).to have_content("Pizza Express")
      expect(page).not_to have_content("Review Pizza Express")
    end

    scenario "user can add a review to a restaurant if it is not theirs" do
      # add_restaurant
      visit "/restaurants"
      click_link "Review Cafe Rouge"
      select("3", from: "review[rating]")
      fill_in("review[review]", with: "Very average")
      click_button "Create Review"
      expect(current_path).to eq "/restaurants/#{cr.id}"
    end

    scenario "user can quit from add new review page without saving it" do
      visit_restaurant(cr)
      click_link("Add review")
      expect(page).to have_content("Cancel")
      click_link("Cancel")
      expect(current_path).to eq("/restaurants/#{cr.id}")
    end

    scenario "users can see who review belongs to" do
      visit "/restaurants/#{cr.id}"
      click_link "Add review"
      select("3", from: "review[rating]")
      fill_in("review[review]", with: "Very average")
      click_button "Create Review"
      expect(page).to have_content("zoe@example.com")
    end

    scenario "a user can not add more than one review for any restaurant" do
      visit "/restaurants/#{cr.id}"
      click_link "Add review"
      select("4", from: "review[rating]")
      fill_in("review[review]", with: "Great bouillabaisse")
      click_button "Create Review"
      expect(page).to have_content("zoe@example.com")

      visit "/restaurants/#{cr.id}"
      click_link "Add review"
      select("5", from: "review[rating]")
      fill_in("review[review]", with: "Really fast service")
      click_button "Create Review"
      expect(current_path).to eq "/restaurants/#{cr.id}"
      expect(page).to_not have_content("Really fast service")
      expect(page).to have_content("You have already reviewed this restaurant")
    end

    scenario "user can delete a review to a restaurant", js: true do
      visit "/restaurants"
      click_link "Review Cafe Rouge"
      select("4", from: "review[rating]")
      fill_in("review[review]", with: "Great bouillabaisse")
      click_button "Create Review"
      expect(current_path).to eq "/restaurants/#{cr.id}"
      expect(page).to have_content("Great bouillabaisse")
      click_link('Destroy Review')
      page.driver.browser.switch_to.alert.accept
      expect(current_path).to eq "/restaurants/#{cr.id}"
      expect(page).not_to have_content("Great bouillabaisse")
    end
  end

  context "not signed in" do
    scenario "The user will be directed to sign up or log in to proceed" do
      visit "/restaurants/#{pe.id}/reviews/new"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
