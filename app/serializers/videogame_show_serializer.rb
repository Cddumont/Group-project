class VideogameShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :release_year, :description

  has_many :reviews
end