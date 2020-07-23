class Api::V1::VideogamesController < ApplicationController
  def index
    render json: Videogame.all
  end
end


