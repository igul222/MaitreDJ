class UsersController < ApplicationController
  def new
  end

  def show
    render text: "hello #{current_user.name}"
  end

  private
  def current_user
    @current_user ||= FoursquareUser.find(session[:user_id])
  end
end