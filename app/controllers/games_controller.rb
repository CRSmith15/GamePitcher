class GamesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new 
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
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
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @games = @user.games.alpha
        else
            @error = "That user does not exist" if params[:user_id]
            @games = Game.alpha
        end

    end

    def show 
        @game = Game.find_by_id(params[:id])
        redirect_to games_path if !@game
    end

    def edit
        @game = Game.find_by_id(params[:id])
        redirect_to games_path if !@game || @game.user != current_user
        @game.build_genre if @game.genre 
    end

    def update 
        @game = Game.find_by(id: params[:id])
        redirect_to games_path if !@game || @game.user != current_user
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


end
