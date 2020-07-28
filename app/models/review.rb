class Review < ApplicationRecord
  validates :rating, 
  numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  belongs_to :videogame
  has_many :upvotes, dependent: :destroy

  def vote_count
    self.upvotes.count
  end
end