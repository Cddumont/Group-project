class Api::V1::UpvotesController < ApplicationController
  def create
    upvote = Upvote.new(user: current_user)
    upvote.review = Review.find(params[:review_id])
    reviews = Review.where(videogame: upvote.review.videogame)
    if upvote.save 
      render json: reviews
    else
      render json: { errors: upvote.errors.full_messages.to_sentence }
    end
  end
end