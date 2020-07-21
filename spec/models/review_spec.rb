require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validation test' do
    it 'ensures rating and videogame_id presence' do
      game = Videogame.create(name: "fifa")
      review = Review.new(rating: 6, videogame: game).save
      expect(review).to eq(true)
     end
    it 'ensures rating is an integer between 1 and 10' do
      game = Videogame.create(name: "fifa")
      review1 = Review.new(rating: 11, videogame: game)
      review2 = Review.new(rating: 0, videogame: game)
      review3 = Review.new(rating: 6, videogame: game)
      review4 = Review.new(rating: "ten", videogame: game)

      expect(review1.valid?).to eq(false)
      expect(review2.valid?).to eq(false)
      expect(review3.valid?).to eq(true)
      expect(review4.valid?).to eq(false)
    end
  end
end
