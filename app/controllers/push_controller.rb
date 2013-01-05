class PushController < ApplicationController
	def index
		event=JSON.parse(request.body.read)
		CHECKIN_ID=event.CHECKIN_ID
		uri = URI.parse("https://api.foursquare.com/v2/checkins/"+CHECKIN_ID+"/reply")

		# Shortcut
		response = Net::HTTP.post_form(uri, {"CHECKIN_ID" => CHECKIN_ID, "url" => new_song_url})
	end
end
