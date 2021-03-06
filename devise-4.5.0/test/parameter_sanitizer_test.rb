# frozen_string_literal: true

require 'test_helper'
require 'devise/parameter_sanitizer'

class ParameterSanitizerTest < ActiveSupport::TestCase
  def sanitizer(params)
    params = ActionController::Parameters.new(params)
    Devise::ParameterSanitizer.new(User, :user, params)
  end

  test 'permits the default parameters for sign in' do
    sanitizer = sanitizer('user' => { 'email' => 'jose' })
    sanitized = sanitizer.sanitize(:sign_in)

    assert_equal({ 'email' => 'jose' }, sanitized)
  end

  test 'permits empty params when received not a hash' do
    sanitizer = sanitizer('user' => 'string')
    sanitized = sanitizer.sanitize(:sign_in)

    assert_equal({}, sanitized)
  end

  test 'does not rise error when received string instead of hash' do
    sanitizer = sanitizer('user' => 'string')
    assert_nothing_raised do
      sanitizer.sanitize(:sign_in)
    end
  end

  test 'does not rise error when received nil instead of hash' do
    sanitizer = sanitizer('user' => nil)
    assert_nothing_raised do
      sanitizer.sanitize(:sign_in)
    end
  end

  test 'permits empty params when received nil instead of hash' do
    sanitizer = sanitizer('user' => nil)
    sanitized = sanitizer.sanitize(:sign_in)

    assert_equal({}, sanitized)
  end

  test 'permits the default parameters for sign up' do
    sanitizer = sanitizer('user' => { 'email' => 'jose', 'role' => 'invalid' })
    sanitized = sanitizer.sanitize(:sign_up)

    assert_equal({ 'email' => 'jose' }, sanitized)
  end

  test 'permits the default parameters for account update' do
    sanitizer = sanitizer('user' => { 'email' => 'jose', 'role' => 'invalid' })
    sanitized = sanitizer.sanitize(:account_update)

    assert_equal({ 'email' => 'jose' }, sanitized)
  end

  test 'permits news parameters for an existing action' do
    sanitizer = sanitizer('user' => { 'username' => 'jose' })
    sanitizer.permit(:sign_in, keys: [:username])
    sanitized = sanitizer.sanitize(:sign_in)

    assert_equal({ 'username' => 'jose' }, sanitized)
  end

  test 'permits news parameters for an existing action with a block' do
    sanitizer = sanitizer('user' => { 'username' => 'jose' })
    sanitizer.permit(:sign_in) do |user|
      user.permit(:username)
    end

    sanitized = sanitizer.sanitize(:sign_in)

    assert_equal({ 'username' => 'jose' }, sanitized)
  end

  test 'permit parameters for new actions' do
    sanitizer = sanitizer('user' => { 'email' => 'jose@omglol', 'name' => 'Jose' })
    sanitizer.permit(:invite_user, keys: %i[email name])

    sanitized = sanitizer.sanitize(:invite_user)

    assert_equal({ 'email' => 'jose@omglol', 'name' => 'Jose' }, sanitized)
  end

  test 'fails when we do not have any permitted parameters for the action' do
    sanitizer = sanitizer('user' => { 'email' => 'jose', 'password' => 'invalid' })

    assert_raise NotImplementedError do
      sanitizer.sanitize(:unknown)
    end
  end

  test 'removes permitted parameters' do
    sanitizer = sanitizer('user' => { 'email' => 'jose@omglol', 'username' => 'jose' })

    sanitizer.permit(:sign_in, keys: [:username], except: [:email])
    sanitized = sanitizer.sanitize(:sign_in)

    assert_equal({ 'username' => 'jose' }, sanitized)
  end
end
