class PagesController < ApplicationController
  def index
  end

  def signup
  end

  def show
    @users = User.all
  end
end
