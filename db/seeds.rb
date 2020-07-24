# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

videogame1 = Videogame.create(name:"Sonic 06", release_year: 2019, description:"Blue dude runs around")
videogame2 = Videogame.create(name:"Cyberpunk 2077", release_year: 2037, description:"Punkguy")
videogame3 = Videogame.create(name:"Frogger", release_year: 2000, description:"Frog cross street, dies.")
videogame4 = Videogame.create(name:"Ratchet and Clank: A Crack in time", release_year: 2006, description:"Cat boy hangs out with smart robot")