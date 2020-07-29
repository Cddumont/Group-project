class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :title, :body, :vote_count
  
  belongs_to :videogame
end