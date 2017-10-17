require 'rails_helper'

feature 'restaurants' do
  scenario 'adding a new restaurant' do
    visit '/restaurants/new'
    expect(page).to have_content('Name')
      fill_in('restaurant[name]', :with => "Montpeliano")
      fill_in('restaurant[address]', :with => "13 Montpelier Street, SW7")
      fill_in('restaurant[description]', :with => "Italian")
      click_button('Save Restaurant')
      expect(current_path).to eq '/restaurants/1'
  end
end
