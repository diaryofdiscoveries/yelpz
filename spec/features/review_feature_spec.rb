require "rails_helper"

feature "reviews" do

  before do
    User.create email: 'zoe@example.com', password: '123456', password_confirmation: '123456'
    visit '/'
    click_link('Sign in')
    fill_in('Email', with: 'zoe@example.com')
    fill_in('Password', with: '123456')
    click_button('Log in')
    visit '/restaurants/new'
    fill_in('restaurant[name]', :with => "Joe's")
    fill_in('restaurant[address]', :with => "London")
    fill_in('restaurant[description]', :with => "Cafe")
    click_button('Create Restaurant')
  end

  scenario "user can add a review to a restaurant" do
    visit "/restaurants"
    click_link "Review Joe's"
    select("4", from: "review[rating]")
    fill_in("review[review]", with: "Great coffee")
    click_button "Create Review"
    expect(current_path).to eq "/restaurants/1"
  end

  scenario "user can delete a review to a restaurant", js: true do
    visit "/restaurants"
    click_link "Review Joe's"
    select("4", from: "review[rating]")
    fill_in("review[review]", with: "Great coffee")
    click_button "Create Review"
    expect(current_path).to eq "/restaurants/1"
    expect(page).to have_content("Great coffee")
    click_link('Destroy Review')
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq '/restaurants/1'
    expect(page).not_to have_content('Great coffee')
  end
end
