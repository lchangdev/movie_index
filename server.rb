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
  title_data = []

  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    title_data << row[:title]
  end
  title_data.sort
end

get '/movies' do
  @movies = load_data('movies.csv')
  @titles = load_titles('movies.csv')

  erb :index
end

get '/movies/:id' do
  @movies = load_data('movies.csv')
  @details = @movies.find do |movieid|
    movieid[:id] == params[:id]
  end

  erb :show
end
