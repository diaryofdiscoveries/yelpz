require "rails_helper"

feature "reviews" do
  before { Restaurant.create name: "Joe's"}

  scenario "user can add a review to a restaurant" do
    visit "/restaurants"
    click_link "Review Joe's"
    select("4", from: "Rating")
    fill_in("Review", with: "Great coffee")
    click_button "Create Review"
    expect(current_path).to eq "/restaurants"
  end
end
