class Api::V1::VideogamesController < ApplicationController
  def index
    render json: Videogame.all
  end

  def show
    videogame = Videogame.find(params["id"])
    reviews = videogame.reviews
    
    render json: {videogame: videogame, reviews: reviews}
  end
end
