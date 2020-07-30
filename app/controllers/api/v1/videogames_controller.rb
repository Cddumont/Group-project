class Api::V1::VideogamesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authorize_user, except: [:index, :show, :create]
  before_action :authenticate_user, except: [:index, :show]

  def index
    render json: Videogame.all
  end

  def create
    videogame = Videogame.new(videogame_params)
    if videogame.save
      render json: {submitted:true} 
    else
      render json: { error: videogame.errors.full_messages.to_sentence, submitted: false }
    end
  end

  def show
    render json: Videogame.find(params["id"]), serializer: VideogameShowSerializer
  end

  def destroy
    videogame = Videogame.find(params["id"])
    videogame.destroy
    render json: { redirect: true }
  end

  private

  def videogame_params
    params.require(:videogame).permit([:name, :release_year, :description])
  end

  def authenticate_user
    if !user_signed_in?
      render json: {error: ["You need to be signed in first"]}
    end
  end

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      render json: { error: "Only Admins May Delete Videogames" }
    end
  end
end