require 'rails_helper'
require 'web_helper'

feature 'restaurants' do

  let!(:user){ User.create(email: "simon@example.com", password: "654321") }
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
    let!(:cr){ Restaurant.create(name: "Cafe Rouge", address: "London", description: "French Bistro", user_id: user.id) }

    scenario 'user can edit a restaurant they created' do
      sign_up
      sign_in
    	visit '/restaurants/new'
    		expect(page).to have_content('Name')
    		fill_in('restaurant[name]', :with => "Pizza Express")
        fill_in('restaurant[address]', :with => "Baker street")
    		fill_in('restaurant[description]', :with => "Italian")
    		click_button('Create Restaurant')
    		# expect(current_path).to eq '/restaurants/1'

        click_link('Edit Pizza Express')
        fill_in('restaurant[name]', :with => "Adele's Bistro")
        fill_in('restaurant[address]', :with => "Chelsea")
        fill_in('restaurant[description]', :with => "French")
        click_button('Update Restaurant')
        # expect(current_path).to eq '/restaurants/1'
    		expect(page).to have_content("Adele's Bistro")
    end

    scenario "user cannot edit a restaurant created by another user" do
      sign_up
      sign_in
    	visit '/restaurants'
      click_link 'Cafe Rouge'
      expect(page).not_to have_content("Edit Cafe Rouge")
    end
  end

  context 'deleting restaurants' do
    let!(:cr){ Restaurant.create(name: "Cafe Rouge", address: "London", description: "French Bistro", user_id: user.id) }

    scenario "should delete a user's restaurant when delete button is pressed and confirmation made", js: true do
      sign_up
      sign_in
      visit '/restaurants/new'
         expect(page).to have_content('Name')
         fill_in('restaurant[name]', :with => "Pizza Express")
         fill_in('restaurant[address]', :with => "Baker street")
         fill_in('restaurant[description]', :with => "Italian")
         click_button('Create Restaurant')
        #  expect(current_path).to eq '/restaurants/1'
         expect(page).to have_content('Pizza Express')
         visit '/restaurants'
         click_link('Delete')
         page.driver.browser.switch_to.alert.accept
         expect(current_path).to eq '/restaurants'
         expect(page).not_to have_content('Pizza Express')
    end

    scenario "should not delete a user's restaurant when delete button is pressed and confirmation not made", js: true do
      sign_up
      sign_in
      visit '/restaurants/new'
         expect(page).to have_content('Name')
         # puts page.body
         # save_and_open_page
         fill_in('restaurant[name]', :with => "Pizza Express")
         fill_in('restaurant[address]', :with => "Baker street")
         fill_in('restaurant[description]', :with => "Italian")
         click_button('Create Restaurant')
        #  expect(current_path).to eq '/restaurants/1'
         expect(page).to have_content('Pizza Express')
         visit '/restaurants'
         click_link('Delete')
         page.driver.browser.switch_to.alert.dismiss
         expect(current_path).to eq '/restaurants'
         expect(page).to have_content('Pizza Express')
    end

    scenario "user cannot delete a restaurant created by another user" do
      sign_up
      sign_in
    	visit '/restaurants'
      click_link 'Cafe Rouge'
      expect(page).not_to have_content("Delete Cafe Rouge")
    end
  end
end
