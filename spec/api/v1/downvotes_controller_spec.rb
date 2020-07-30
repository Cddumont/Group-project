require 'rails_helper'

RSpec.describe Api::V1::DownvotesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe "POST#create" do
    let!(:videogame1) {Videogame.create(name:"Spyro")}
    let!(:review1) {Review.create(rating: 3, videogame: videogame1)}

    it "returns error message if user is not signed in" do 
      post :create, params: {review_id: review1.id}
      returned_json = JSON.parse(response.body)
      
      expect(returned_json['errors']).to eq("User must exist")
    end

    it "returns error message if user has already downvoted" do
      binding.pry
      sign_in user
      binding.pry
      Downvote.create(user: user, review: review1)
      
      post :create, params: {review_id: review1.id}
      returned_json = JSON.parse(response.body)

      expect(returned_json["errors"]).to eq("Review has already been taken and User has already been taken")
    end

    it "if user is signed in it creates a downvote" do
      sign_in user

      post :create, params: {review_id: review1.id}

      expect(user.downvotes.count).to eq(1)
    end
    it "returns json of all the reviews" do
      sign_in user

      post :create, params: {review_id: review1.id}
      returned_json = JSON.parse(response.body)

      expect(returned_json).to be_kind_of(Hash)
      expect(returned_json["reviews"]).to be_kind_of(Array)
      expect(returned_json["reviews"].first["rating"]).to eq(review1.rating)
    end
    it "if the user already upvoted the review, it destroys the upvote" do
      Upvote.create(user: user, review: review1)
      upvoteCount = user.upvotes.count
      sign_in user

      post :create, params: {review_id: review1.id}

      expect(user.upvotes.count).to eq(upvoteCount - 1)
    end
  end
end