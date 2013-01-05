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
		#response = Net::HTTP.post_form(uri, {"CHECKIN_ID" => checkin_id, "url" => new_song_url})
		logger.info("CHECKIN_ID:"+checkin_id.inspect)
		logger.info("URI:"+uri.inspect)
		logger.info("URL:"+new_song_url.inspect)
	end
end
