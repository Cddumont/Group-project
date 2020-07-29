class Api::V1::ReviewsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_user!


  def create
    review = Review.new(review_params)
    if review.save
      render json: { submitted: true, review: review } 
    else
      render json: { submitted: false }
    end
  end

  private

  def review_params
    params.require(:review).permit([:rating, :body, :title, :videogame_id])
  end
end