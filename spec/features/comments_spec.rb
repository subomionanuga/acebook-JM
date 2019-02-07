require 'rails_helper'
require 'webhelper'

describe 'Comments' do
  it 'can be made on a post' do
    go_homepage
    sign_up
    create_post
    click_link 'Sign out'
    sign_up2
    click_link 'test@test.com'
    fill_in 'comment', with: 'this photo has changed my life'
    click_button 'Post comment'
    expect(page).to have_content('test2@test.com | this photo has changed my life')
  end
  # it 'are attributed to the user who wrote them' do
  #   go_homepage
  #   sign_up
  #   create_post
  # end
end