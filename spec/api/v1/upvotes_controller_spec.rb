require 'rails_helper'

RSpec.describe Api::V1::UpvotesController, type: :controller do
  describe "POST#create" do
    let!(:videogame1) {Videogame.create(name:"Spyro")}
    let!(:review1) {Review.create(rating: 3, videogame: videogame1)}

    it "returns error message if user is not signed in" do 
      post :create, params: {review_id: review1.id}
      returned_json = JSON.parse(response.body)
      
      expect(returned_json['errors']).to eq("User must exist")
    end
    it "returns error message if user has already upvoted" do
      user = FactoryBot.create(:user)
      sign_in user
      Upvote.create(user: user, review: review1)
      
      post :create, params: {review_id: review1.id}
      returned_json = JSON.parse(response.body)

      expect(returned_json["errors"]).to eq("Review has already been taken and User has already been taken")
    end
    it "if user is signed in it creates an upvote" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {review_id: review1.id}

      expect(user.upvotes.count).to eq(1)
    end
    it "returns json of all the reviews" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {review_id: review1.id}
      returned_json = JSON.parse(response.body)

      expect(returned_json).to be_kind_of(Hash)
      expect(returned_json["reviews"]).to be_kind_of(Array)
      expect(returned_json["reviews"].first["rating"]).to eq(review1.rating)
    end
    it "if the user already downvoted the review, it destroys the downvote" do
      user = FactoryBot.create(:user)
      Downvote.create(user: user, review: review1)
      downvoteCount = user.downvotes.count
      sign_in user

      post :create, params: {review_id: review1.id}

      expect(user.downvotes.count).to eq(downvoteCount - 1)
    end
  end
end