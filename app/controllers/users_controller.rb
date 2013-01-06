class UsersController < ApplicationController
  def new
  end

  def show
    respond_to do |format|
      format.html # index.html.erb
      format.json { render text:"Hello" }
    end
  end

  private
  def current_user
    @current_user ||= FoursquareUser.find(session[:user_id])
  end
end