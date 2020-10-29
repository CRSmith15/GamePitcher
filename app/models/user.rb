class User < ApplicationRecord
    has_many :games
    has_many :comments
    has_many :commented_games, through: :comments, source: :game 
    has_many :genres, through: :games
end
