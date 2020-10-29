class GamesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new 
        @game = Game.new
    end

    def create 
        @game = current_user.games.build(game_params)
        binding.pry
        if @game.save 
            redirect_to games_path 
        else
            render :new 
        end

    end


    private 

    def game_params
         params.require(:game).permit(:title, :description)
    end


end
