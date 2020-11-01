module GamesHelper
    def show_games_header
        if @user 
          "#{@user.username}'s Game Pitches:"
        else
          "All Game Pitches"
        end
    end

end
