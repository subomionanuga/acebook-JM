require 'rails_helper'
require "webhelper"

feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    go_homepage
    sign_up
    create_post
    expect(page).to have_content("Hello, world!")
  end

  scenario " Submitted posts are assigned to a user " do
    go_homepage
    sign_up
    create_post
    expect(page).to have_content("created by test@test.com - user 3")
  end

  scenario "User can't delete another user's post" do 
    go_homepage
    sign_up
    create_post
    click_link "Sign out"
    sign_up2
    click_link "posts"
    click_link "Delete Post"
    expect(page).to have_content("Hello, world!")
  end

end
