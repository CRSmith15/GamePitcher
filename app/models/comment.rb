class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :text, presence: true

  validates :game, uniqueness: {scope: :user_id, message: "may only have one comment per user."}
end
