
require "open-uri"
require "yaml"

puts "Cleaning DB"

Movie.destroy_all
TvShow.destroy_all
Director.destroy_all

file = "https://gist.githubusercontent.com/ssaunier/25920c896baa0e4495fd/raw/9c26ce104c15fc237126bf6b136b8e318368f8ad/imdb.yml"
sample = YAML.load(open(file).read)

puts 'Creating directors...'
directors = {}  # slug => Director
sample["directors"].each do |director|
  directors[director["slug"]] = Director.create! director.slice("first_name", "last_name")
end

puts 'Creating movies...'
sample["movies"].each do |movie|
  Movie.create! movie.slice("title", "year", "syllabus").merge(director: directors[movie["director_slug"]])
end

puts 'Creating tv shows...'
sample["series"].each do |tv_show|
  TvShow.create! tv_show
end
puts 'Finished!'
