require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'


get '/' do
  erb :index
end

post "/result" do
  movie_hash = params[:movie]

  # Make a HTTP request to the omdb api
  response = Typhoeus.get("www.omdbapi.com", :params => {:s => "#{movie_hash}"})

  movie_results = JSON.parse(response.body)

  @movies = movie_results['Search'].sort_by {|movie| movie['Year']}

  erb :result

end

get "/poster/:imdb" do 
  imdb_id = params[:imdb]
  # Make another api call here to get the url of the poster.
  response = Typhoeus.get("www.omdbapi.com", :params => {:i => "#{imdb_id}"})

  @movie = JSON.parse(response.body)

  erb :poster

end


