def sign_up
  User.create email: 'zoe@example.com', password: '123456', password_confirmation: '123456'
end

def sign_in
  visit '/'
  click_link('Sign in')
  fill_in('Email', with: 'zoe@example.com')
  fill_in('Password', with: '123456')
  click_button('Log in')
end

def add_restaurant
  visit '/restaurants/new'
  fill_in('restaurant[name]', :with => "Joe's")
  fill_in('restaurant[address]', :with => "London")
  fill_in('restaurant[description]', :with => "Cafe")
  click_button('Create Restaurant')
end
