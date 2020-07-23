class Api::V1::VideogamesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    render json: Videogame.all
  end
  def create
    Videogame.create(params[:videogame])
  end

  private

  def videogame_params
    params.require(:videogame).permit([:name, :release_year, :description])
  end
end


