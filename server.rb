require 'sinatra'
require 'csv'
require 'shotgun'
require 'pry'

def load_data(csv)
  movies_data = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    movies_data << row
  end
  movies_data
end

def load_titles(csv)

  id_title_hash = {}
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    id_title_hash[row[:id]] = row[:title]

  end
  sorted_movies = id_title_hash.sort_by {|k,v| v}
  Hash[sorted_movies]
end

get '/' do
  erb :index
end

get '/movies' do
  @movies = load_data('movies.csv')
  @titles = load_titles('movies.csv')

  erb :movies
end

get '/movies/:movie_id' do
  @movies = load_data('movies.csv')
  @details = @movies.find do |movieid|
    movieid[:id] == params[:movie_id]
  end

  erb :show
end
