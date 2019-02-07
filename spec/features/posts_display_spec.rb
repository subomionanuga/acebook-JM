require 'rails_helper'
require 'webhelper'
require 'timecop'

describe 'posts show the date they were posted' do
  it 'post should have a visible date' do
    Timecop.freeze
    go_homepage
    sign_up
    create_post
    expect(page).to have_content(Time.now.strftime('%a, %d, %b, %Y, %H:%M:%S'))
  end
end
