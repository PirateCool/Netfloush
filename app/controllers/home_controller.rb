class HomeController < ApplicationController

	def index
		print params
		if params[:search]
			@search = params[:search]
			@movie = MovieScrapper.new.perform(@search)
		end
	end

end
