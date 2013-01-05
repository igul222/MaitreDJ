class SongController < ApplicationController
	def new
		@song=Song.new
	end
	def create
		Song.create(params[:song])
	end
end
