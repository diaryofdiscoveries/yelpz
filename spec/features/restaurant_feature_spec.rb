require 'rails_helper'
require 'web_helper'

feature 'restaurants' do

  # let!(:user1){ User.create(email: "zoe@example.com", password: "123456") }
  #
  # let!(:pe){ Restaurant.create(name: "Pizza Express", address: "Kings road", description: "Italian", user_id: user1.id) }
  # let!(:cr){ Restaurant.create(name: "Cafe Rouge", address: "Kensington Church Street", description: "French bistro", user_id: user1.id) }

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      sign_in
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add restaurant'
    end
  end

  context 'restaurant has been added' do
    scenario 'should display restaurant' do
      sign_up
      sign_in
      visit '/restaurants/new'
      fill_in('restaurant[name]', :with => "Pizza Express")
      fill_in('restaurant[address]', :with => "London")
      fill_in('restaurant[description]', :with => "Italian")
      click_button('Create Restaurant')
      visit '/restaurants'
      expect(page).to have_content("Pizza Express")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "editing restaurants" do
    scenario 'should edit restaurant in db when restaurant is edited in edit page' do
      sign_up
      sign_in
    	visit '/restaurants/new'
    		expect(page).to have_content('Name')
        # puts page.body
        # save_and_open_page
    		fill_in('restaurant[name]', :with => "Cafe Rouge")
        fill_in('restaurant[address]', :with => "Kensington Church Street")
    		fill_in('restaurant[description]', :with => "French Bistro")
    		click_button('Create Restaurant')
    		# expect(current_path).to eq '/restaurants/1'

        click_link('Edit')
        fill_in('restaurant[name]', :with => "Adele's Bistro")
        fill_in('restaurant[address]', :with => "Chelsea")
        fill_in('restaurant[description]', :with => "French")
        click_button('Update Restaurant')
        # expect(current_path).to eq '/restaurants/1'
    		expect(page).to have_content("Adele's Bistro")
    end
  end

  context 'deleting restaurants' do
    scenario 'should delete a restaurant when delete button is pressed and confirmation made', js: true do
      sign_up
      sign_in
      visit '/restaurants/new'
         expect(page).to have_content('Name')
         # puts page.body
         # save_and_open_page
         fill_in('restaurant[name]', :with => "Cafe Rouge")
         fill_in('restaurant[address]', :with => "Kensington Church Street")
         fill_in('restaurant[description]', :with => "French Bistro")
         click_button('Create Restaurant')
        #  expect(current_path).to eq '/restaurants/1'
         expect(page).to have_content('Cafe Rouge')
         visit '/restaurants'
         click_link('Delete')
         page.driver.browser.switch_to.alert.accept
         expect(current_path).to eq '/restaurants'
         expect(page).not_to have_content('Cafe Rouge')
    end

    scenario 'should not delete a restaurant when delete button is pressed and confirmation not made', js: true do
      sign_up
      sign_in
      visit '/restaurants/new'
         expect(page).to have_content('Name')
         # puts page.body
         # save_and_open_page
         fill_in('restaurant[name]', :with => "Cafe Rouge")
         fill_in('restaurant[address]', :with => "Kensington Church Street")
         fill_in('restaurant[description]', :with => "French Bistro")
         click_button('Create Restaurant')
        #  expect(current_path).to eq '/restaurants/1'
         expect(page).to have_content('Cafe Rouge')
         visit '/restaurants'
         click_link('Delete')
         page.driver.browser.switch_to.alert.dismiss
         expect(current_path).to eq '/restaurants'
         expect(page).to have_content('Cafe Rouge')
    end
  end
end
