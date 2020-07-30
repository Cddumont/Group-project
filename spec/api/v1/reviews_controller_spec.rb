require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  describe "POST#create" do
    let!(:videogame1) {Videogame.create(name:"Spyro")}
    let!(:videogame2) {Videogame.create(name:"Sonic The Hedgehog")}
    it "creates a new review" do
      post_json = {
        review: {
          rating: 3,
          title: "new review",
          body: "this is a great game",
          videogame_id: videogame1.id
        }
      }
      user = FactoryBot.create(:user)
      sign_in user

      prev_count = Review.count
      post :create, params: post_json
      expect(Review.count).to eq(prev_count + 1)
    end
    it "if creation is successful, it returns json with a key of submitted:true and a key of review containing the new review object" do
      post_json = {
        review: {
          rating: 3,
          title: "new review",
          body: "this is a great game",
          videogame_id: videogame1.id
        }
      }
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: post_json
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")

      expect(returned_json).to be_kind_of(Hash)
      expect(returned_json).to_not be_kind_of(Array)
      expect(returned_json["submitted"]).to eq true
      expect(returned_json["review"]["rating"]).to eq (Review.last.rating)
      expect(returned_json["review"]["body"]).to eq (Review.last.body)
      expect(returned_json["review"]["title"]).to eq (Review.last.title)
    end
    it "if invalid form submission, returns the json with a key of submitted:false" do
      post_json = {
        review: {
          rating: "",
          title: "new review",
          body: "this is a great game",
          videogame_id: videogame1.id
        }
      }
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: post_json
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")

      expect(returned_json).to be_kind_of(Hash)
      expect(returned_json).to_not be_kind_of(Array)
      expect(returned_json["submitted"]).to eq false
    end
  end
end