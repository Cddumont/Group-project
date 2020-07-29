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
  end

end