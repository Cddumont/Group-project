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

      expect(returned_json.length).to eq(6)
      expect(returned_json["name"]).to eq(videogame1.name)
      expect(returned_json["id"]).to eq(videogame1.id)
      expect(returned_json["release_year"]).to eq(videogame1.release_year)
      expect(returned_json["description"]).to eq(videogame1.description)
    end
  end
end
