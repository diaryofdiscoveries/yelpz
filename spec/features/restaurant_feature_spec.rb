require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurant has been added' do
    scenario 'should display restaurant' do
      Restaurant.create(name: "Pizza Express")
      visit '/restaurants'
      expect(page).to have_content("Pizza Express")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "editing restaurants" do
    scenario 'should edit restaurant in db when restaurant is edited in edit page' do
    	 visit '/restaurants/new'
    			expect(page).to have_content('Name')
          # puts page.body
          # save_and_open_page
    			fill_in('restaurant[name]', :with => "Cafe Rouge")
          fill_in('restaurant[address]', :with => "Kensington Church Street")
    			fill_in('restaurant[description]', :with => "French Bistro")
    			click_button('Create Restaurant')
    			expect(current_path).to eq '/restaurants/1'

          click_link('Edit')
          fill_in('restaurant[name]', :with => "Adele's Bistro")
          fill_in('restaurant[address]', :with => "Chelsea")
          fill_in('restaurant[description]', :with => "French")
          click_button('Update Restaurant')
          expect(current_path).to eq '/restaurants/1'
    			expect(page).to have_content("Adele's Bistro")
    end
  end

  context 'deleting restaurants' do
    scenario 'should delete a restaurant when delete button is pressed' do
      visit '/restaurants/new'
         expect(page).to have_content('Name')
         # puts page.body
         # save_and_open_page
         fill_in('restaurant[name]', :with => "Cafe Rouge")
         fill_in('restaurant[address]', :with => "Kensington Church Street")
         fill_in('restaurant[description]', :with => "French Bistro")
         click_button('Create Restaurant')
         expect(current_path).to eq '/restaurants/1'
         expect(page).to have_content('Cafe Rouge')

         click_link('Delete')
         page.driver.browser.switch_to.alert.accept
         expect(current_path).to eq '/restaurants'
         expect(page).not_to have_content('Cafe Rouge')
    end
  end
end
