class VideogameSerializer < ActiveModel::Serializer
  attributes :id, :name, :release_year, :description
end