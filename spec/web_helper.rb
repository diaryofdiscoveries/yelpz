def sign_up(email: "sam@example.com", password: "654321", password_confirmation: "654321")
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: email)
  fill_in('Password', with: password)
  fill_in('Password confirmation', with: password_confirmation)
  click_button('Sign up')
end

def sign_in(email: "zoe@example.com", password: "123456")
  visit '/'
  click_link('Sign in')
  fill_in('Email', with: email)
  fill_in('Password', with: password)
  click_button('Log in')
end

def sign_out
  click_link('Sign out')
end

def add_restaurant(name: "Joe's", address: "London", description: "Cafe")
  visit '/restaurants/new'
  fill_in('restaurant[name]', :with => name)
  fill_in('restaurant[address]', :with => address)
  fill_in('restaurant[description]', :with => description)
  click_button('Create Restaurant')
end

def edit_restaurant(name: "Joe's", address: "South Kensington", description: "British Cafe", restaurant: )
  visit_restaurant(restaurant)
  click_link "Edit #{restaurant.name}"
  fill_in('restaurant[name]', :with => name)
  fill_in('restaurant[address]', :with => address)
  fill_in('restaurant[description]', :with => description)
  click_button 'Update Restaurant'
end

def visit_restaurant(restaurant)
  visit("/restaurants")
  click_link(restaurant.name)
end

def visit_restaurant_and_add_review(rating: "4", comment: "Tasty chicken", restaurant: )
  visit_restaurant(restaurant)
  click_link "Add review"
  add_review(rating: rating, review: review, restaurant: restaurant)
end

def add_review(rating: "4", review: "Great pizza", restaurant: )
  fill_in('Review', with: review)
  select(rating, from: "Rating")
  click_button "Create Review"
end
