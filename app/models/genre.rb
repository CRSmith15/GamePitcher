class Genre < ApplicationRecord
    has_many :games
    has_many :users, through: :games

    scope :alpha, -> { order(:name) }
end
