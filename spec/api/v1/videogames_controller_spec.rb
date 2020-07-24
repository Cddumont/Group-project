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

      expect(returned_json[0]["name"]).to eq(videogame1.name)
      expect(returned_json[0]["id"]).to eq(videogame1.id)

      expect(returned_json[1]["name"]).to eq(videogame2.name)
      expect(returned_json[1]["id"]).to eq(videogame2.id)
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