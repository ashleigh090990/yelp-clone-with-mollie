require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  def leave_review(thoughts, rating)
    visit '/'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'allow users to leave a review using a form' do 
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('lovely', 3)
    leave_review('not lovely', 5)
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
