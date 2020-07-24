class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :title, :body
  
  belongs_to :videogame
end