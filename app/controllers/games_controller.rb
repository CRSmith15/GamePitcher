class GamesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new 
        if match_user
            @game = @user.games.build
        else
            @game = Game.new
        end
         @game.build_genre
    end

    def create 
        @game = current_user.games.build(game_params)
        if @game.save 
            redirect_to games_path 
        else
            render :new 
        end

    end

    def index 
        if match_user
            @games = @user.games.alpha
        else
            @error = "That user does not exist" if params[:user_id]
            @games = Game.alpha
        end

    end

    def show 
        set_game
    end
    

    def edit
        set_game
        redirect_to games_path if @game.user != current_user
        @game.build_genre if @game.genre 
    end

    def update 
        set_game
        redirect_to games_path if @game.user != current_user
        if @game.update(game_params)
            redirect_to game_path(@game)
        else
            render :edit 
        end
    end

    def destroy 
        @game = Game.find_by_id(params[:id])
        @game.destroy 
        redirect_to user_games_path(@game.user)
    end






    private 

    def game_params
        params.require(:game).permit(:title, :description, :genre_id, genre_attributes: [:name])
    end

    def match_user 
        params[:user_id] && @user = User.find_by_id(params[:user_id])
    end

    def set_game 
        @game = Game.find_by_id(params[:id])
        redirect_to games_path if !@game
    end


end
