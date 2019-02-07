# frozen_string_literal: true

require 'rails_helper'
require 'webhelper'

feature 'Timeline', type: :feature do
  scenario 'Can submit posts and view them' do
    go_homepage
    sign_up
    create_post
    expect(page).to have_content('Hello, world!')
  end
end

feature 'Users and post relationship ', type: :feature do
  scenario ' Submitted posts are assigned to a user ' do
    go_homepage
    sign_up
    create_post
    expect(page).to have_content('created by test@test.com')
  end
end

feature 'Users action on posts ', type: :feature do
  scenario "User can't delete another user's post" do
    go_homepage
    sign_up
    create_post
    click_link 'Sign out'
    sign_up2
    click_link 'Posts'
    expect(page).to have_no_content('Delete Posts')
  end

  scenario "User can't edit another user's posts" do
    go_homepage
    sign_up
    create_post
    click_link 'Sign out'
    sign_up2
    click_link 'Posts'
    visit '/posts/6/edit'
    fill_in 'Message', with: "Trying to steal someone else's post!"
    click_button 'Submit'
    expect(page).to have_content('You cannot edit that post, you snake!')
    expect(page).to have_no_content("Trying to steal someone else's post!")
  end
end
