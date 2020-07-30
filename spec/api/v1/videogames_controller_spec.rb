require 'rails_helper'

RSpec.describe Api::V1::VideogamesController, type: :controller do
  describe "GET#Index" do
    let!(:videogame1) {Videogame.create(name:"Spyro")}
    let!(:videogame2) {Videogame.create(name:"Sonic The Hedgehog")}

    it "returns a status of 200" do
      get :index
      
      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
    end

    it "returns all the videogames in the database" do
      get :index
      
      returned_json = JSON.parse(response.body)
      
      expect(returned_json["videogames"][0]["name"]).to eq(videogame1.name)
      expect(returned_json["videogames"][0]["id"]).to eq(videogame1.id)

      expect(returned_json["videogames"][1]["name"]).to eq(videogame2.name)
      expect(returned_json["videogames"][1]["id"]).to eq(videogame2.id)
    end
  end

  describe "GET#Show" do
    let!(:videogame1) {Videogame.create(name:"Spyro", release_year: 2006, description: "blah")}
    let!(:videogame2) {Videogame.create(name:"Sonic The Hedgehog", release_year: 1992, description: "hot")}

    it "return a status of 200" do
      get :show, params: {id: videogame1.id}
      
      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
    end

    it "returns a specific videogame in the database" do
      get :show, params: {id: videogame1.id}

      returned_json = JSON.parse(response.body)

      expect(returned_json["videogame"].length).to eq(6)
      expect(returned_json["videogame"]["name"]).to eq(videogame1.name)
      expect(returned_json["videogame"]["id"]).to eq(videogame1.id)
      expect(returned_json["videogame"]["release_year"]).to eq(videogame1.release_year)
      expect(returned_json["videogame"]["description"]).to eq(videogame1.description)
    end

    it "returns all of the associated reviews for the videogame" do
      review1 = Review.create(rating: 5, body: "short", title:"hi", videogame: videogame1)
      Review.create(rating: 5, body: "hi", title:"short", videogame: videogame1)
      Review.create(rating: 5, body: "hi", title:"short", videogame: videogame2)

      get :show, params: {id: videogame1.id}

      returned_json = JSON.parse(response.body)

      expect(returned_json["videogame"]["reviews"].length).to eq(2)
      expect(returned_json["videogame"]["reviews"][0]["rating"]).to eq(review1.rating)
      expect(returned_json["videogame"]["reviews"][0]["body"]).to eq(review1.body)
      expect(returned_json["videogame"]["reviews"][0]["title"]).to eq(review1.title)
    end
  end
  describe "POST#create" do
    it "creates a new VideoGame" do
      post_json = {
        videogame: {
          name: "Title",
          release_year: "1854",
          description: "describes game"
        }
      }

      user = FactoryBot.create(:user)
      sign_in user

      prev_count = Videogame.count
      post :create, params: post_json
      expect(Videogame.count).to eq(prev_count + 1)
    end
    it "returns the json with a key of submitted:true if successful" do
      post_json = {
        videogame: {
          name: "Title",
          release_year: "1854",
          description: "describes game"
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
    end
    it "if invalid form submission, returns the json with a key of submitted:false and a key of error" do
      post_json = {
        videogame: {
          name: "",
          release_year: "1854",
          description: "describes game"
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
      expect(returned_json["error"]).to eq "Name can't be blank"
    end
  end
end