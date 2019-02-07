# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @users = User.all
  end

  def signup; end

  def show
    @users = User.all
  end
end
