class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :title, :body, :videogame_id
  
  belongs_to :videogame
end