require 'rails_helper'

RSpec.describe Videogame, type: :model do
  context 'validation test' do
    it 'ensures name presence' do
      game = Videogame.new(name: 'fifa').save
      game2 = Videogame.new(description: 'cool game').save
       expect(game).to eq(true)
       expect(game2).to eq(false)
     end
  end
end
