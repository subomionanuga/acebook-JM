require 'rails_helper'
require 'webhelper'
require 'timecop'
require 'orderly'

describe "Posts" do
  it "should have a visible date" do
    Timecop.freeze
    go_homepage
    sign_up
    create_post
  expect(page).to have_content(Time.now.strftime('%a, %d, %b, %Y, %H:%M:%S'))
  end

  it "should display newest first" do
    go_homepage
    sign_up
    create_post
    create_second_post
    expect('My second post, MOO!').to appear_before('Hello, world!')
  end
end

