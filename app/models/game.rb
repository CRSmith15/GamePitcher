class Game < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments

  validates :title, :description, presence: true
  validate :pitch_limit, :on => :create


  def pitch_limit 
    #binding.pry
    todays_pitches = user.games.select do |g|
      g.created_at.try(:to_date) == Date.today
    end
    if todays_pitches.size > 3
      errors.add(:game_id, "No more than 3 new pitches per day.")
    end
  end

end
