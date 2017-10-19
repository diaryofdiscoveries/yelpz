require 'rails_helper'

feature 'restaurants' do

  before do
    User.create email: 'zoe@example.com', password: '123456', password_confirmation: '123456'
    visit '/'
    click_link('Sign in')
    fill_in('Email', with: 'zoe@example.com')
    fill_in('Password', with: '123456')
    click_button('Log in')
  end

  scenario 'adding a new restaurant' do
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
      visit '/restaurants/new'
      click_button('Create Restaurant')
      expect(page).to have_content("Name can't be blank")
    end
  end

  context 'adding a restaurant name with less than 2 letters' do
    it 'cannot be added to database/site' do
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
      visit '/restaurants/new'
      fill_in('restaurant[name]', :with => "Pizza Express")
      fill_in('restaurant[address]', :with => "London")
      fill_in('restaurant[description]', :with => "Italian")
      click_button('Create Restaurant')
      visit '/restaurants/new'
      fill_in('restaurant[name]', :with => "Pizza Express")
      fill_in('restaurant[address]', :with => "London")
      fill_in('restaurant[description]', :with => "Italian")
      click_button('Create Restaurant')
      expect(page).to have_content("Name has already been taken")
    end
  end
end
