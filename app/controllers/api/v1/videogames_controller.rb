class Api::V1::VideogamesController < ApplicationController
  def index
    render json: Videogame.all
  end

  def show
    render json: Videogame.find(params["id"])
  end
end