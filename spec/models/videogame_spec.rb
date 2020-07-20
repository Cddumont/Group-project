require 'rails_helper'

RSpec.describe Videogame, type: :model do
  context 'validation test' do
    it 'ensures name presence' do
      game = Videogame.new(name: 'fifa').save
       expect(game).to eq(true)
     end
  end
end
