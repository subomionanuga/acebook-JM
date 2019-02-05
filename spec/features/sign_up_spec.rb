require 'rails_helper'
require 'webhelper'

describe "sign up", type: :feature do
  scenario "user can sign up" do
    go_homepage
    expect(current_path).to eq('/')
  end
end

describe "sign up", type: :feature do
  scenario "user can sign up" do
    go_homepage
    sign_up
    expect(page).to have_content('Currently logged in as test@test.com')
  end
end

describe "Authentication" do
  scenario "User must sign up/in to access posts" do
    go_homepage
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Sign up')
    visit '/posts'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
  scenario "user must provide email with valid email format" do
    go_homepage
    sign_up_bad_email
    expect(page).to have_content("Sign up 1 error prohibited this user from being saved: Email is invalid")
  end
  scenario "password must be 6 characters or more" do
    go_homepage
    sign_up_short_password
    expect(page).to have_content("1 error prohibited this user from being saved: Password is too short (minimum is 6 characters)")
    end

end

describe "User" do
  scenario "can visit other users pages" do
    go_homepage
    sign_up
    click_link "Sign out"
    click_link "Sign up"
    fill_in "user[email]", with: "second@test.com"
    fill_in "user[password]", with: "secondpassword"
    fill_in "user[password_confirmation]", with: "testpassword"
    click_button 'Sign up'
    visit '/users/2'
    expect(page).to have_content("you are viewing test@test.com's page")
  end


end
