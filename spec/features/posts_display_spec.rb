require 'rails_helper'
require 'webhelper'

describe "posts show the date they were posted" do
  it "post should have a visible date" do
    go_homepage
    sign_up
    create_post
  expect(page).to have_content("Tuesday 07/02/2019")
  end
end
