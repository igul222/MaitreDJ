class UsersController < ApplicationController
  def new
  end

  def show
  end

  private
  def current_user
    @current_user ||= FoursquareUser.find(session[:user_id])
  end
end