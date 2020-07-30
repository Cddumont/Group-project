class VideogameShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :release_year, :description, :admin_user

  def admin_user
    if current_user
      return current_user.admin?
    else
      return false
    end
  end

  has_many :reviews
end