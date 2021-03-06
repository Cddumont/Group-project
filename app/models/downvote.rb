class Downvote <ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :review, uniqueness: {scope: :user}
  validates :user, uniqueness: {scope: :review}
end