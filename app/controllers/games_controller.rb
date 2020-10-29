class GamesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new 
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @game = @user.posts.build
        else
            @game = Game.new
        end
            @game.build_genre
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
         params.require(:game).permit(:title, :description, :genre_id, genre_attributes: [:name])
    end


end
