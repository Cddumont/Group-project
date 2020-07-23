class Api::V1::VideogamesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    render json: Videogame.all
  end
  def create
    videogame = Videogame.new(videogame_params)
    if videogame.save
      render json: { videogame: videogame }
    else
      render json: { error: videogame.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def videogame_params
    params.require(:videogame).permit([:name, :release_year, :description])
  end
end


