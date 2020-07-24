class VideogameSerializer < ActiveModel::Serializer
  attributes :id, :name, :release_year, :description, :review_ids

end
