class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index 
        if params[:game_id] && @game = Game.find_by_id(params[:game_id])
            @comments = @game.comments 
        else
            @comments = Comment.all 
        end
    end

    def new 
        if params[:game_id] && @game = Game.find_by_id(params[:game_id])
            @comment = @game.comments.build
        else
            @comment = Comment.new 
        end

    end


    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save 
            redirect_to comment_path(@comment)
        else
            render :new 
        end

    end

    def show 
        @comment = Comment.find_by_id(params[:id])
        redirect_to comments_path if !@comment 
    end


    private 

    def comment_params
        params.require(:comment).permit(:text, :game_id)
    end



end
