require 'uri'
class PushController < ApplicationController
	def index
		@event=JSON.parse(URI.unescape(params[:checkin]))
		logger.info("Event:"+@event.inspect)
		#@event=JSON.parse(request.body.read)
		checkin_id=@event['id']
		logger.info("ID"+checkin_id.inspect)
		uri = URI.parse("https://api.foursquare.com/v2/checkins/"+checkin_id+"/reply")

		# Shortcut
		req = Net::HTTP::Post.new(uri.path)
		req.set_form_data({'CHECKIN_ID'=>checkin_id, 'url'=>url})
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		response = http.request(req)
		logger.info("Response:"+response.inspect)

		logger.info("CHECKIN_ID:"+checkin_id.inspect)
		logger.info("URI:"+uri.inspect)
		logger.info("URL:"+new_song_url.inspect)

		render :text => 'OK'
	end
end
