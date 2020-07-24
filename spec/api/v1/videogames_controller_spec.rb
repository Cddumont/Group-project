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

    # it "returns the json of the newly posted gif" do
    #   post_json = {
    #     name: "Basset Hound Shakes Off",
    #     url: "https://media.giphy.com/media/WjjXDenYaxQys/giphy.gif"
    #   }.to_json

    #   post(:create, body: post_json)
    #   returned_json = JSON.parse(response.body)
    #   expect(response.status).to eq 200
    #   expect(response.content_type).to eq("application/json")

    #   expect(returned_json).to be_kind_of(Hash)
    #   expect(returned_json).to_not be_kind_of(Array)
    #   expect(returned_json["name"]).to eq "Basset Hound Shakes Off"
    #   expect(returned_json["url"]).to eq "https://media.giphy.com/media/WjjXDenYaxQys/giphy.gif"
    # end
  end
  describe "POST#create" do
    it "creates a new VideoGame" do
      post_json = {
        videogame: {
          name: "Title",
          release_year: "1854",
          description: "describes game"
        }
      }.to_json

      prev_count = Videogame.count
      post(:create, 
        {body: post_json,
        credentials: "same-origin", 
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json"
        }}
      )
      expect(Videogame.count).to eq(prev_count + 1)
    end
  end
end