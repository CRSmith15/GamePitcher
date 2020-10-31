class Game < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments

  validates :title, :description, :genre, presence: true
end
