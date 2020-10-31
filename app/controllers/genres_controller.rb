class GenresController < ApplicationController

    def index 
        @genres = Genre.all.alpha.includes(:games)
    end

    def show 
        @genre = Genre.find_by_id(params[:id])
        @genre.games.alpha
    end

    def new 
    end



end
