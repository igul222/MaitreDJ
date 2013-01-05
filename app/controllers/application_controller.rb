class ApplicationController < ActionController::Base
  protect_from_forgery
  def default_url_options
    if Rails.env.production?
      {:host => "maitredj.herokuapp.com"}
    else  
      {:host => "localhost:3000"}
    end
  end
end
