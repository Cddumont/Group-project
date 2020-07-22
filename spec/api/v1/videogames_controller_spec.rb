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
end
