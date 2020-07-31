require 'faraday'
require 'faraday_middleware'
require 'betterlorem'

Videogame.destroy_all
Review.destroy_all
User.destroy_all

url = 'https://api.rawg.io/api/games?dates=2010-01-01,2019-12-31&ordering=-added'

conn = Faraday.new(url: url) do |faraday|
  faraday.adapter Faraday.default_adapter
  faraday.response :json
end

conn.get.body["results"].each do |game|
  Videogame.create(
    name: game["name"],
    release_year: game["released"],
    image: game["background_image"],
    description: BetterLorem.p(1, true, true)
  )
end

100.times do
  Review.create(
    rating: (rand(5) + 1), 
    title: BetterLorem.w(10, true, true), 
    body: BetterLorem.p(1, true, true),
    videogame: Videogame.all.sample
  )
end

200.times do
  user = User.new(
    username: BetterLorem.w((rand(11) + 1), true, true),
    first_name: BetterLorem.w(5, true, true),
    last_name: BetterLorem.w(5, true, true),
    email: "#{rand()}@gmail.com",
    password: BetterLorem.w(10, true, true)
  )
  user.save
end

400.times do
  Upvote.create(
    user: User.all.sample,
    review: Review.all.sample
  )
end

400.times do
  Downvote.create(
    user: User.all.sample,
    review: Review.all.sample
  )
end
