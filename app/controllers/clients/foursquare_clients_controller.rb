class Clients::FoursquareClientsController < ApplicationController
	def new
		# https://developer.foursquare.com/overview/auth
		options = {
		  redirect_uri: callback_foursquare_clients_url,
		}
		redirect_to client.auth_code.authorize_url options
	end

	def callback
		if params[:error]
			debugger
			Logger.error(params[:error])
		end
		token = client.auth_code.get_token params[:code], redirect_uri: callback_foursquare_clients_url
		user = FoursquareUser.find_or_create_by_access_token(token.token)

		Rails.cache.write(user.foursquare_id, token.token)
		
		console.log 'WRITTEN TO GLOBAL HACKS'
		console.log user.foursquare_id 
		console.log token.token

		session[:user_id] = user.id
		redirect_to user_path
	end

	private
	def client
	  FoursquareClient.oauth2_client
	end
end