require 'rails_helper'
require 'web_helper'

feature 'restaurants' do

  scenario 'a user must be logged in to create restaurants' do
    visit '/restaurants/new'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(page).not_to have_content('Name')
  end

  scenario 'adding a new restaurant' do
    sign_up
    sign_in
    visit '/restaurants/new'
    expect(page).to have_content('Name')
      fill_in('restaurant[name]', :with => "Montpeliano")
      fill_in('restaurant[address]', :with => "13 Montpelier Street, SW7")
      fill_in('restaurant[description]', :with => "Italian")
      click_button('Create Restaurant')
      expect(current_path).to eq '/restaurants/1'
  end

  context 'adding a blank restaurant name' do
    it 'cannot be added to database/site' do
      sign_up
      sign_in
      visit '/restaurants/new'
      click_button('Create Restaurant')
      expect(page).to have_content("Name can't be blank")
    end
  end

  context 'adding a restaurant name with less than 2 letters' do
    it 'cannot be added to database/site' do
      sign_up
      sign_in
      visit '/restaurants/new'
      fill_in('restaurant[name]', :with => "M")
      fill_in('restaurant[address]', :with => "13 Montpelier Street, SW7")
      fill_in('restaurant[description]', :with => "Italian")
      click_button('Create Restaurant')
      expect(page).to have_content("Name is too short")
    end
  end

  context "adding a duplicate restaurant name" do
    it 'cannot be added to database/site' do
      sign_up
      sign_in
      add_restaurant
      visit '/restaurants/new'
      fill_in('restaurant[name]', :with => "Joe's")
      fill_in('restaurant[address]', :with => "London")
      fill_in('restaurant[description]', :with => "Cafe")
      click_button('Create Restaurant')
      expect(page).to have_content("Name has already been taken")
    end
  end
end
