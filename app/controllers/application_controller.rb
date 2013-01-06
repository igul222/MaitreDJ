class ApplicationController < ActionController::Base
  protect_from_forgery
  def default_url_options
    if Rails.env.production?
      {:host => "www.jamsesh.in"}
    else  
      {:host => "localhost:3000"}
    end
  end
end
