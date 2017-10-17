describe 'site homepage' do

  feature 'visiting the homepage' do

    it 'has a link that takes you to the restaurant list' do
      visit '/'
      expect(page).to have_content('Crowd-sourced reviews about local businesses')
      click('Yelpz Businesses')
      expect(current_path).to eq ('/restaurants')
    end

  end

end
