class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index 
        if params[:game_id] && @game = Game.find_by_id(params[:game_id])
            @comments = @game.comments 
        else
            @comments = Comment.all 
        end
    end

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save 
            redirect_to comments_path 
        else
            render :new 
        end

    end

    def show 
    end


    private 

    def comment_params
        params.require(:comment).permit(:text, :game_id)
    end



end
