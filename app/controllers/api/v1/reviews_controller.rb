class Api::V1::ReviewsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authorize_user, except: [:create]
  before_action :authenticate_user

  def create
    review = Review.new(review_params)
    if review.save
      render json: review
    else
      render json: { error: "Please select a rating" }
    end
  end

  def destroy
    review = Review.find(params["id"])
    reviews = review.videogame.reviews
    review.destroy
    render json: reviews
  end

  private

  def review_params
    params.require(:review).permit([:rating, :body, :title, :videogame_id])
  end

  def authenticate_user
    if !user_signed_in?
      render json: {error: ["You need to be signed in first"]}
    end
  end

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      render json: { error: "Only Admins May Delete Reviews" }
    end
  end
end