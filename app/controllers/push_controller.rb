require 'uri'
class PushController < ApplicationController
	def index
		@event=JSON.parse(URI.unescape(params[:checkin]))
		logger.info("Event:"+@event.inspect)
		#@event=JSON.parse(request.body.read)
		checkin_id=@event[:id]
		logger.info("ID"+checkin_id.inpsect)
		uri = URI.parse("https://api.foursquare.com/v2/checkins/"+checkin_id+"/reply")

		# Shortcut
		response = Net::HTTP.post_form(uri, {"CHECKIN_ID" => checkin_id, "url" => new_song_url})
	end
end
