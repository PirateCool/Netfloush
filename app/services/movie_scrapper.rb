require 'themoviedb'
require 'dotenv'
Dotenv.load


class MovieScrapper

	def initialize
	
		@films = []
	end
	
	def perform(search)

		Tmdb::Api.key(ENV['SECRET_KEY'])

		Tmdb::Api.language("en")

		configuration = Tmdb::Configuration.new
		@find = Tmdb::Movie.find(search)

		@find.each do |movie|

			@film = {}

			@moviehash = Tmdb::Movie.credits(movie.id)
			@moviecrew = @moviehash.fetch("crew")
			#je récupere la valeur de "crew", c'est un hash composé d'infos de réalisateurs
			@moviedetails = Tmdb::Movie.detail(movie.id)

			@movierealease = Tmdb::Movie.releases(movie.id)

			@film[:title] = @moviedetails["title"]
			@film[:date] = @moviedetails["release_date"]

			if  @moviedetails["poster_path"]
			@imageok = configuration.base_url + configuration.poster_sizes[3] + @moviedetails["poster_path"]
			@film[:image] = @imageok
			else
			@imagenotok = "http://image.noelshack.com/fichiers/2018/45/4/1541681140-noposter.jpg"
			@film[:image] = @imagenotok
			end



			@moviecrew.each do |info|

				if info["job"] == "Director"
					@film[:director] = info["name"]
				end
			end
			@films.push(@film)
			puts ""
			puts ""
		end
			return @films		
	end
end