class Api::V1::DownvotesController < ApplicationController
  def create
    downvote = Downvote.new(user: current_user)
    downvote.review = Review.find(params[:review_id])
    reviews = Review.where(videogame: downvote.review.videogame)
    if downvote.save 
      render json: reviews
    else
      render json: { errors: downvote.errors.full_messages.to_sentence }
    end
  end
end