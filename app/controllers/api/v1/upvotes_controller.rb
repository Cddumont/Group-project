class Api::V1::UpvotesController < ApplicationController
  def create
    # binding.pry
    upvote = Upvote.new(user: current_user)
    upvote.review = Review.find(params[:review_id])
    if upvote.save 
      # binding.pry
      render json: upvote.review
    else
      binding.pry
    end
  end
  
  private

    # def upvote_params
    #   params.require(:upvote).permit(:user)
    # end
end