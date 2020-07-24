class Api::V1::VideogamesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    render json: Videogame.all
  end

  def create
    binding.pry
    videogame = Videogame.new(videogame_params)
    if videogame.save
      render json: {submitted:true} 
    else
      render json: { error: videogame.errors.full_messages, submitted:false }
    end
  end

  private

  def videogame_params
    params.require(:videogame).permit([:name, :release_year, :description])
  end
end


