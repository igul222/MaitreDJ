class SongsController < ApplicationController
	def new
		@song=Song.new
		respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @song }
	    end
	end
	def create
		@song= Song.new(params[:song])
		respond_to do |format|
	      if @song.save
	        logger.info("Song:"+@song.query+" saved")
	      else
	        format.html { render action: "new" }
	        format.json { render json: @song.errors, status: :unprocessable_entity }
	      end
	    end
	end
end
