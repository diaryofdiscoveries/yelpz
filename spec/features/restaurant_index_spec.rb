require "rails_helper"

feature "restaurants" do

  before do
    User.create email: 'zoe@example.com', password: '123456', password_confirmation: '123456'
    visit '/'
    click_link('Sign in')
    fill_in('Email', with: 'zoe@example.com')
    fill_in('Password', with: '123456')
    click_button('Log in')
  end

  context "restaurants are visible in the list of restaurants" do
    scenario "should display 2 restaurants after creating them" do
       visit '/restaurants/new'
       fill_in('restaurant[name]', :with => "Pizza Express")
       fill_in('restaurant[address]', :with => "Kings Road")
       fill_in('restaurant[description]', :with => "Italian")
       click_button('Create Restaurant')
       visit '/restaurants/new'
       fill_in('restaurant[name]', :with => "McDonalds")
       fill_in('restaurant[address]', :with => "Piccadilly Circus")
       fill_in('restaurant[description]', :with => "Burgers")
       click_button('Create Restaurant')
       visit "/restaurants"
       expect(page).to have_content("Pizza Express")
       expect(page).to have_content("McDonalds")
       expect(page).not_to have_content("No restaurants yet")
     end
   end
 end
